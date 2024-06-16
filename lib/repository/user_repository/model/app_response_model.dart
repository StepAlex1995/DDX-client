class AppResponseModel<T> {
  final int code;
  final T? data;

  AppResponseModel({required this.code, this.data});

  @override
  String toString() {
    return 'AppResponseModel{code: $code, data: $data}';
  }
}
