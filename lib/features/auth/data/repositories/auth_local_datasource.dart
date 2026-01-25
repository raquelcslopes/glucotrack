import 'package:flutter_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _uidKey = 'CACHED_USER_ID';

  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheUserId(String uid) async {
    await prefs.setString(_uidKey, uid);
  }

  @override
  Future<String?> getCachedUserId() async {
    return prefs.getString(_uidKey);
  }

  @override
  Future<void> clear() async {
    await prefs.remove(_uidKey);
  }
}
