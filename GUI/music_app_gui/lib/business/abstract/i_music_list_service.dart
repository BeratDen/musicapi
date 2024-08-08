import 'package:music_app_gui/business/abstract/i_service.dart';

abstract class IMusicListService extends IService {
  @override
  String get url => '/music/lists/';
}
