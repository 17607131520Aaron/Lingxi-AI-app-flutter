import 'package:shared_preferences/shared_preferences.dart';

import '../core/auth/token_store.dart';
import '../core/network/api_client.dart';
import '../core/storage/app_storage.dart';

class AppServices {
  AppServices();

  static final AppServices instance = AppServices();

  late final AppStorage storage;
  late final TokenStore tokenStore;
  late final ApiClient apiClient;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    storage = AppStorage(prefs);
    tokenStore = TokenStore(storage);
    apiClient = ApiClient(tokenStore: tokenStore);
  }
}
