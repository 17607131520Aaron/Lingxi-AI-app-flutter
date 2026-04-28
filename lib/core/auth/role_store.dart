import '../storage/app_storage.dart';
import '../storage/storage_keys.dart';
import 'app_role.dart';

class RoleStore {
  RoleStore(this.storage);

  final AppStorage storage;

  AppRole readRole() {
    return AppRole.fromValue(storage.getString(StorageKeys.appRole));
  }

  Future<bool> saveRole(AppRole role) {
    return storage.setString(StorageKeys.appRole, role.value);
  }
}
