import 'package:music_app_gui/business/abstract/i_service.dart';

abstract class IAlbumService implements IService {
  @override
  String get url => "/music/albums/";
}
