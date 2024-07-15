import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app_gui/models/category.dart';
import 'package:music_app_gui/utils/cloud_api.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:music_app_gui/views/components/primary_button.dart';

class AddArtist extends StatefulWidget {
  const AddArtist({super.key});

  @override
  State<AddArtist> createState() => _AddArtistState();
}

class _AddArtistState extends State<AddArtist> {
  late CloudApi api;
  late CrudRepository artistRepository;
  final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  HttpApiClient apiClient = HttpApiClient();

  late File _image;
  Uint8List _imageBytes = Uint8List(0);
  String? _imageName;

  @override
  void initState() {
    super.initState();
    artistRepository =
        CrudRepository('${dotenv.env['SERVER']}/music/musicians/', apiClient);
    rootBundle
        .loadString('assets/credentials.json')
        .then((json) => {api = CloudApi(json)});
  }

  Future<List<Category>> setCategoryOptions() async {
    List<Category> categories = [];
    var response =
        await DioClient.dio.get('${dotenv.env['SERVER']}/music/categories');
    for (var category in response.data) {
      categories.add(Category.fromJson(category));
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Color(Colors.grey[850]?.value ?? 0xFF000000),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Add Artist',
                              style: GoogleFonts.lato(
                                  color: Colors.grey[200], fontSize: 24),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FormBuilderTextField(
                              name: 'first_name',
                              decoration: InputDecoration(
                                labelText: 'First Name *',
                                labelStyle: TextStyle(color: Colors.grey[400]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[900]!, width: 2.0),
                                ),
                                hoverColor: Colors.grey[800],
                                fillColor: Colors.grey[850],
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.grey[200]),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'last_name',
                              decoration: InputDecoration(
                                labelText: 'Last Name *',
                                labelStyle: TextStyle(color: Colors.grey[400]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[900]!, width: 2.0),
                                ),
                                hoverColor: Colors.grey[800],
                                fillColor: Colors.grey[850],
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.grey[200]),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _imageBytes.isNotEmpty
                                    ? Stack(
                                        children: [Image.memory(_imageBytes)])
                                    : Text('No image selected',
                                        style:
                                            TextStyle(color: Colors.grey[200])),
                                PrimaryButton(
                                    onPressed: () async {
                                      final pickedFile = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      setState(() {
                                        if (pickedFile != null) {
                                          debugPrint(pickedFile.path);
                                          _image = File(pickedFile.path);
                                          _imageBytes =
                                              _image.readAsBytesSync();
                                          _imageName =
                                              _image.path.split('/').last;
                                        } else {
                                          debugPrint('no image available');
                                        }
                                      });
                                    },
                                    child: Text('Upload Image',
                                        style: TextStyle(
                                            color: Colors.grey[200]))),
                              ],
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'resume',
                              maxLines: 8,
                              decoration: InputDecoration(
                                labelText: 'Resume *',
                                labelStyle: TextStyle(color: Colors.grey[400]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[900]!, width: 2.0),
                                ),
                                hoverColor: Colors.grey[800],
                                fillColor: Colors.grey[850],
                                filled: true,
                              ),
                              style: TextStyle(color: Colors.grey[200]),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                            ),
                            const SizedBox(height: 10),
                            FutureBuilder<List<Category>>(
                              future: setCategoryOptions(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return FormBuilderCheckboxGroup(
                                    checkColor: Colors.grey[200],
                                    activeColor: const Color.fromARGB(
                                        255, 127, 124, 255),
                                    decoration: InputDecoration(
                                      labelText: 'Categories',
                                      labelStyle:
                                          TextStyle(color: Colors.grey[200]),
                                    ),
                                    wrapSpacing: 5,
                                    name: 'category',
                                    options: snapshot.data!
                                        .map((category) =>
                                            FormBuilderFieldOption(
                                              value: category.value,
                                              child: Text(
                                                category.name,
                                                style: TextStyle(
                                                    color: Colors.grey[200]),
                                              ),
                                            ))
                                        .toList(),
                                  );
                                } else {
                                  return const Text('loading');
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: PrimaryButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      const snackBar = SnackBar(
                                        duration: Duration(seconds: 30),
                                        content: Row(
                                          children: [
                                            CircularProgressIndicator(),
                                            Text("Adding Artist...")
                                          ],
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      try {
                                        var response = await createArtist();
                                        if (response.statusCode == 200) {
                                          _formKey.currentState!.reset();
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        }
                                      } on DioException catch (e) {
                                        throw Exception(e.message);
                                      }
                                    }
                                  },
                                  child: Text('Add Artist',
                                      style:
                                          TextStyle(color: Colors.grey[200]))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<Response<dynamic>> createArtist() async {
    Map<String, dynamic> data = Map.from(_formKey.currentState!.value);
    final imageResponse = await api.save(_imageName!, _imageBytes);
    data['avatar'] = imageResponse.downloadLink.toString();
    return await artistRepository.create(data);
  }
}
