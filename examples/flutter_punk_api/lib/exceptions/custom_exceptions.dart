class FetchDataException implements Exception {
  FetchDataException(this.message);

  final String message;
  final _prefix = 'Error during HTTP call: ';

  String toString() {
    return '$_prefix$message';
  }
}
