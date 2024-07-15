import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/utils/cloud_api.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:music_app_gui/views/components/primary_button.dart';
import 'package:intl/intl.dart';

class AddAlbum extends StatefulWidget {
  const AddAlbum({super.key});

  @override
  State<AddAlbum> createState() => _AddAlbumState();
}

class _AddAlbumState extends State<AddAlbum> {
  late CloudApi api;
  late CrudRepository albumRepository;
  final _formKey = GlobalKey<FormBuilderState>();
  final picker = ImagePicker();
  HttpApiClient apiClient = HttpApiClient();

  late File _image;
  Uint8List _imageBytes = Uint8List(0);
  String? _imageName;

  @override
  void initState() {
    super.initState();
    albumRepository =
        CrudRepository('${dotenv.env['SERVER']}/music/albums/', apiClient);
    rootBundle
        .loadString('assets/credentials.json')
        .then((json) => {api = CloudApi(json)});
  }

  Future<List<Artist>> setArtistOptions() async {
    List<Artist> artists = [];
    var response =
        await DioClient.dio.get('${dotenv.env['SERVER']}/music/musicians');
    for (var artist in response.data) {
      artists.add(Artist.fromJson(artist));
    }
    return artists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
                              'Add Album',
                              style: GoogleFonts.lato(
                                  color: Colors.grey[200], fontSize: 24),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: InputDecoration(
                                labelText: 'Name *',
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
                            FutureBuilder<List<Artist>>(
                              future: setArtistOptions(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return FormBuilderDropdown(
                                    validator: FormBuilderValidators.compose(
                                        [FormBuilderValidators.required()]),
                                    decoration: InputDecoration(
                                        labelText: 'Artist',
                                        labelStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[900]!,
                                              width: 2.0),
                                        )),
                                    style: TextStyle(color: Colors.grey[200]),
                                    dropdownColor: Colors.grey[800],
                                    name: 'artist',
                                    items: snapshot.data!
                                        .map((e) => DropdownMenuItem(
                                              value: e.value,
                                              child: Text(
                                                  '${e.firstName!} ${e.lastName!}'),
                                            ))
                                        .toList(),
                                  );
                                } else {
                                  return const Text('Loading');
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            FormBuilderDateTimePicker(
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                              name: 'release_date',
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                labelText: 'Release Date *',
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
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                              name: 'num_stars',
                              decoration: InputDecoration(
                                labelText: 'Number of stars *',
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
                            ),
                            const SizedBox(height: 20),
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
                                        var response = await createAlbum();
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

  Future<Response<dynamic>> createAlbum() async {
    Map<String, dynamic> data = Map.from(_formKey.currentState!.value);
    final imageResponse = await api.save(_imageName!, _imageBytes);
    String isoFormattedDate =
        DateFormat('yyyy-MM-dd').format(data['release_date']);
    data['release_date'] = isoFormattedDate;
    data['image'] = imageResponse.downloadLink.toString();
    return await albumRepository.create(data);
  }
}
