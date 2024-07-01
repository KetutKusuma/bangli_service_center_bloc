class ReturnResponseModel<T> {
  bool? status = false;
  String message = 'Error default';
  T? data;

  ReturnResponseModel({
    this.status = false,
    required this.message,
    this.data,
  });

  @override
  String toString() {
    // TODO: implement toString
    return '''{
              'status' : '$status',
              'message' : '$message',
              'data' : $data,
            }''';
  }

  /// ini adalah returnResponse Sukses Umum
  /// ini dapat berisi data dan message
  ///
  /// status pasti true
  factory ReturnResponseModel.success(String message, {dynamic data}) {
    return ReturnResponseModel(status: true, message: message, data: data);
  }

  /// ini fungsi mengembalikan sukses dengan custom data single(singular)
  /// yang mana data dapat dikembalikan sebagai model
  /// dengan memasukkan fungsi pada create object
  /// contohnya (element) => UserModel.fromjson(element)
  /// maka data akan berisi dengan UserModel
  factory ReturnResponseModel.successWDataNFunc({
    String? message,
    required Map<String, dynamic>? json,
    required Function(Map<String, dynamic> element)? createObject,
  }) {
    return ReturnResponseModel<T>(
      message: message ?? "Sukses",
      data: createObject!(json ?? {}),
    );
  }

  /// ini adalah fungsi untuk mengembalikan sukses dengan custom data jamak(banyak)
  /// contohnya :
  ///
  /// createObject : (data) => data.map(
  ///                (e) => VendorModel.fromJson(e),
  ///              )
  ///           .toList(),
  factory ReturnResponseModel.successWListDataNFunc({
    String message = "Sukses",
    required List<Map<String, dynamic>> data,
    required Function(List<Map<String, dynamic>> element)? createObject,
  }) {
    return ReturnResponseModel<T>(
      message: message,
      data: createObject!(data),
    );
  }

  /// ini adalah returnResponse Gagal Umum
  ///
  /// status pasti false
  factory ReturnResponseModel.failed(String message) {
    return ReturnResponseModel(status: false, message: message, data: null);
  }
}
