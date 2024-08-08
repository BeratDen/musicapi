abstract class IService {
  final String url = "/music/";

  Future<dynamic> list();
  Future<dynamic> listByIds(List<dynamic>? ids);
  Future<dynamic> get(String id);

  Future<bool> create(dynamic data);
  Future<bool> update(dynamic data);
  Future<bool> delete(String id);
}
