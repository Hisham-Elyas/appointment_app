class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
  @override
  String toString() {
    return message;
    // return super.toString();
  }
}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}
