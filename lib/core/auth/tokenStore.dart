import '../storage/appStorage.dart';
import '../storage/storageKeys.dart';

class TokenStore {
  TokenStore(this.storage);

  final AppStorage storage;

  String? readToken() => storage.getString(StorageKeys.authToken);

  Future<bool> saveToken(String token) {
    return storage.setString(StorageKeys.authToken, token);
  }

  Future<bool> clearToken() {
    return storage.remove(StorageKeys.authToken);
  }
}
