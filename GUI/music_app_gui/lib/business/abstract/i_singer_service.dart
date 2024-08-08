import 'package:music_app_gui/business/abstract/i_service.dart';

abstract class ISingerService implements IService {
  @override
  // TODO: implement url
  String get url => "/music/musicians/";
}
