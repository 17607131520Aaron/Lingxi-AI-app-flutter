class ApiResult<T> {
  const ApiResult({required this.success, required this.message, this.code, this.data, this.raw});

  final bool success;
  final int? code;
  final String message;
  final T? data;
  final dynamic raw;
}
