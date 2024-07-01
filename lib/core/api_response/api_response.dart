class ApiResponseModel {
  final int? statusCode;
  bool isSuccess = false;
  String? message;
  dynamic errorMessage;
  final dynamic data;

  ApiResponseModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    required this.errorMessage,
    required this.data,
  });

  factory ApiResponseModel.successFromJson(Map<String, dynamic> response) {
    return ApiResponseModel(
      statusCode: response['code'],
      isSuccess: true,
      message: response['message'],
      errorMessage: [],
      data: response['data'],
    );
  }

  factory ApiResponseModel.errorFromJson(Map<String, dynamic> response) {
    return ApiResponseModel(
      statusCode: response['code'],
      isSuccess: false,
      message: response['message'],
      errorMessage: response['error'],
      data: {},
    );
  }

  factory ApiResponseModel.fromJson(Map<String, dynamic> response) {
    return ApiResponseModel(
      statusCode: response['code'],
      isSuccess: true,
      message: response['message'],
      errorMessage: response['error'],
      data: response['data'],
    );
  }

  factory ApiResponseModel.fromSelfModel(ApiResponseModel response) {
    return ApiResponseModel(
      statusCode: response.statusCode,
      isSuccess: response.isSuccess,
      message: response.message,
      errorMessage: response.errorMessage,
      data: response.data,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return '''Api Response Model : {
                'status_code' : $statusCode,
                'isSuccess' : $isSuccess,
                'message' : $message,
                'error_message' : $errorMessage,
                'data' : $data,
             }''';
  }
}
