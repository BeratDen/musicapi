import 'package:music_app_gui/business/abstract/i_service.dart';

abstract class IMusicService extends IService {
  @override
  String get url => '/music/musics';
}
