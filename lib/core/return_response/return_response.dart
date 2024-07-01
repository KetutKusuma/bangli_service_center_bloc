class ReturnResponse<T> {
  bool status = false;
  String message = 'Error default';
  T? data;

  ReturnResponse({
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
  factory ReturnResponse.success(String message, {dynamic data}) {
    return ReturnResponse(status: true, message: message, data: data);
  }

  /// ini fungsi mengembalikan sukses dengan custom data single(singular)
  /// yang mana data dapat dikembalikan sebagai model
  /// dengan memasukkan fungsi pada create object
  /// contohnya (element) => UserModel.fromjson(element)
  /// maka data akan berisi dengan UserModel
  factory ReturnResponse.successWDataNFunc({
    String? message,
    required Map<String, dynamic>? json,
    required Function(Map<String, dynamic> element)? createObject,
  }) {
    return ReturnResponse<T>(
      status: true,
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
  factory ReturnResponse.successWListDataNFunc({
    String message = "Sukses",
    required List<Map<String, dynamic>> data,
    required Function(List<Map<String, dynamic>> element)? createObject,
  }) {
    return ReturnResponse<T>(
      status: true,
      message: message,
      data: createObject!(data),
    );
  }

  /// ini adalah returnResponse Gagal Umum
  ///
  /// status pasti false
  factory ReturnResponse.failed(String message, {dynamic data}) {
    return ReturnResponse(status: false, message: message, data: data);
  }
}
