import 'dart:typed_data';
import "package:googleapis_auth/auth_io.dart" as auth;
import 'package:gcloud/storage.dart';
import 'package:mime/mime.dart';

class CloudApi {
  final auth.ServiceAccountCredentials _credantials;

  CloudApi(String json)
      : _credantials = auth.ServiceAccountCredentials.fromJson(json);

  Future<ObjectInfo> save(String name, Uint8List imageBytes) async {
    // TODO: create client
    auth.AuthClient client =
        await auth.clientViaServiceAccount(_credantials, Storage.SCOPES);

    // TODO: Instantiate objects to cloud storage
    var storage = Storage(client, 'MusicHub');
    var bucket = storage.bucket('hub_bucket_1');

    //TODO:  save to bucket
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final type = lookupMimeType(name);
    return await bucket.writeBytes(name, imageBytes,
        metadata: ObjectMetadata(
            contentType: type, custom: {'timestamp': timestamp.toString()}));
  }
}
