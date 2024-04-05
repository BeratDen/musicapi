import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/category.dart';
import 'package:music_app_gui/models/user.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:music_app_gui/views/components/primary_button.dart';
import 'package:music_app_gui/utils/cloud_api.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class AddMusic extends StatefulWidget {
  const AddMusic({super.key});

  @override
  State<AddMusic> createState() => _AddMusicState();
}

class _AddMusicState extends State<AddMusic> {
  final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HttpApiClient apiClient = HttpApiClient();
  late CrudRepository musicRepository;

  late File _image;
  Uint8List _imageBytes = Uint8List(0);
  String? _imageName;

  late File _mp3;
  Uint8List _mp3Bytes = Uint8List(0);
  String? _mp3Name;

  final picker = ImagePicker();
  late CloudApi api;

  final user = User.getInstance();

  @override
  void initState() {
    super.initState();
    musicRepository =
        CrudRepository('${dotenv.env['SERVER']}/music/musics/', apiClient);
    rootBundle
        .loadString('assets/credentials.json')
        .then((json) => {api = CloudApi(json)});
  }

  Future<List<Artist>> setArtistOptions() async {
    List<Artist> artists = [];
    var response =
        await DioClient.dio.get('${dotenv.env['SERVER']}/music/musicians/');
    for (var artist in response.data) {
      artists.add(Artist.fromJson(artist));
    }
    return artists;
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

  Future<List<Album>> setAlbumOptions() async {
    List<Album> albums = [];
    var response =
        await DioClient.dio.get('${dotenv.env['SERVER']}/music/albums');
    for (var album in response.data) {
      albums.add(Album.fromJson(album));
    }
    return albums;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  // Replace Expanded with Flexible
                  flex: 1,
                  fit: FlexFit.loose, // Set FlexFit.loose
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Add Music',
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
                            FormBuilderTextField(
                              name: 'lyric',
                              decoration: InputDecoration(
                                labelText: 'Lyric',
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
                            // Artists
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
                            // Categories
                            FutureBuilder<List<Category>>(
                              future: setCategoryOptions(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return FormBuilderCheckboxGroup(
                                    checkColor: Colors.grey[200],
                                    activeColor:
                                        Color.fromARGB(255, 127, 124, 255),
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
                            // Albums
                            FutureBuilder<List<Album>>(
                              future: setAlbumOptions(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return FormBuilderCheckboxGroup(
                                    checkColor: Colors.grey[200],
                                    activeColor:
                                        Color.fromARGB(255, 127, 124, 255),
                                    decoration: InputDecoration(
                                      labelText: 'Albums',
                                      labelStyle:
                                          TextStyle(color: Colors.grey[200]),
                                    ),
                                    name: 'albums',
                                    wrapSpacing: 5,
                                    options: snapshot.data!
                                        .map((album) => FormBuilderFieldOption(
                                              value: album.value,
                                              child: Text(
                                                album.name,
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
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _mp3Bytes.isNotEmpty
                                    ? Text(
                                        'MP 3 Selected $_mp3Name',
                                        style:
                                            TextStyle(color: Colors.grey[200]),
                                      )
                                    : Text(
                                        'No mp3 selected',
                                        style:
                                            TextStyle(color: Colors.grey[200]),
                                      ),
                                PrimaryButton(
                                    onPressed: () async {
                                      final pickedFile =
                                          await FilePicker.platform.pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: ['mp3']);
                                      setState(() {
                                        if (pickedFile != null) {
                                          debugPrint(pickedFile.paths[0]);
                                          _mp3 = File(pickedFile.paths[0]!);
                                          _mp3Bytes = _mp3.readAsBytesSync();
                                          _mp3Name = _mp3.path.split('/').last;
                                        } else {
                                          debugPrint('no image available');
                                        }
                                      });
                                    },
                                    child: Text(
                                      'Upload MP3',
                                      style: TextStyle(color: Colors.grey[200]),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _imageBytes.isNotEmpty
                                    ? Stack(
                                        children: [Image.memory(_imageBytes)],
                                      )
                                    : Text(
                                        'No image selected',
                                        style:
                                            TextStyle(color: Colors.grey[200]),
                                      ),
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
                                    child: Text(
                                      'Upload Image',
                                      style: TextStyle(color: Colors.grey[200]),
                                    )),
                                const SizedBox(height: 10),
                              ],
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'video_url',
                              decoration: InputDecoration(
                                labelText: 'Video URL',
                                labelStyle: TextStyle(color: Colors.grey[400]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[900]!, width: 2.0),
                                ),
                                hoverColor: Colors.grey[800],
                                fillColor: Colors.grey[850],
                                filled: true,
                              ),
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
                              padding: const EdgeInsets.all(8.0),
                              child: PrimaryButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    const snackBar = SnackBar(
                                      duration: Duration(seconds: 30),
                                      content: Row(
                                        children: [
                                          CircularProgressIndicator(),
                                          Text("Logging In...")
                                        ],
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    try {
                                      var response = await createMusic();
                                      if (response.statusCode == 200) {
                                        // TODO : do something with it
                                        _formKey.currentState?.reset();
                                      }
                                      // _formKey.currentState!.reset();
                                    } on DioException catch (e) {
                                      debugPrint("error : ${e.response?.data}");
                                    }
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  }
                                },
                                child: Text(
                                  'Add Music',
                                  style: TextStyle(color: Colors.grey[200]),
                                ),
                              ),
                            ),
                          ],
                          //
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Response<dynamic>> createMusic() async {
    _formKey.currentState?.save();
    Map<String, dynamic> data = Map.from(_formKey.currentState!.value);
    final imgResponse = await api.save(_imageName!, _imageBytes);
    final mp3Response = await api.save(_mp3Name!, _mp3Bytes);
    String isoFormattedDate =
        DateFormat('yyyy-MM-dd').format(data['release_date']);

    data['release_date'] = isoFormattedDate;
    data['image_url'] = imgResponse.downloadLink.toString();
    data['music_url'] = mp3Response.downloadLink.toString();
    data['uploader'] = 'http://127.0.0.1:8000${user.value}';
    if (data['albums'] == null) {
      data['albums'] = [];
    }
    return await musicRepository.create(data);
  }
}
