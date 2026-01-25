abstract class AuthLocalDataSource {
  Future<void> cacheUserId(String uid);
  Future<String?> getCachedUserId();
  Future<void> clear();
}
