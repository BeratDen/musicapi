
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/models/user.dart';
import 'package:music_app_gui/utils/cloud_api.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/globals.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:intl/intl.dart';

class MusicsController extends GetxController {
  var isLoading = false.obs;
  List<Music> musics = [];
  HttpApiClient apiClient = HttpApiClient();
  late CrudRepository musicRepository;
  late CloudApi api;
  final user = User.getInstance();

  @override
  Future<void> onInit() async {
    super.onInit();
    musicRepository =
        CrudRepository('$globalServerUrl/music/musics/', apiClient);
    rootBundle
        .loadString('assets/credentials.json')
        .then((json) => {api = CloudApi(json)});
    fetchData();
  }

  fetchData() async {
    try {
      isLoading(true);

      List<Music> newMusics = [];
      var response =
          await DioClient.dio.get('$globalServerUrl/music/musics/session');
      if (response.statusCode == 200) {
        for (var music in response.data) {
          newMusics.add(Music.fromJson(music));
        }
      }
      musics = newMusics;
      update();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  addItem(GlobalKey<FormBuilderState> formKey, imageName, imageBytes,
      mp3Name, mp3Bytes) async {
    try {
      isLoading(true);
      formKey.currentState?.save();
      Map<String, dynamic> data = Map.from(formKey.currentState!.value);
      final imgResponse = await api.save(imageName!, imageBytes);
      final mp3Response = await api.save(mp3Name!, mp3Bytes);
      String isoFormattedDate =
          DateFormat('yyyy-MM-dd').format(data['release_date']);

      data['release_date'] = isoFormattedDate;
      data['image_url'] = imgResponse.downloadLink.toString();
      data['music_url'] = mp3Response.downloadLink.toString();
      data['uploader'] = 'http://127.0.0.1:8000${user.value}';
      if (data['albums'] == null) {
        data['albums'] = [];
      }

      var response = await musicRepository.create(data);
      if (response.statusMessage == 'Created') {
        Music music = Music.fromJson(response.data);
        musics.add(music);
        update();
        isLoading(false);
      }
    } on dio.DioException catch (e) {
      debugPrint(e.message!);
    } finally {
      isLoading(false);
    }
  }

  removeItem(Music music) async {
    try {
      isLoading.value = true;
      var response = await musicRepository.delete(music.value);
      if (response.statusMessage == 'No Content') {
        musics.remove(music);
        update();
        isLoading(false);
      }
    } on dio.DioException catch (e) {
      debugPrint(e.message!);
    } finally {
      isLoading(false);
    }
  }
}
