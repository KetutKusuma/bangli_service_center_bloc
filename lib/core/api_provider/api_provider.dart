import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bangli_service_center_bloc/src/common/path_api.dart';
import 'package:http/http.dart' as http;
import '../api_response/api_response.dart';
import 'base_api_impl.dart';

///---- API RESPONSE ----
ApiResponseModel apiResponseModelError = ApiResponseModel(
  statusCode: 500,
  isSuccess: false,
  message: 'Error',
  errorMessage: 'Error default',
  data: null,
);

class ApiProvider implements BaseApiImpl {
  ApiProvider._();

  static final internalCall = ApiProvider._();

  factory ApiProvider() => internalCall;

  Future<ApiResponseModel> _parseResponse(
      Map<String, dynamic> decodedData) async {
    return ApiResponseModel.fromJson(decodedData);
  }

  @override
  Future<ApiResponseModel> delete(
    String url, {
    bool isUseToken = false,
    String? token,
    String? param,
  }) async {
    // TODO: implement delete
    if (isUseToken) {
      assert(token == null, "required token");
    } else {
      assert(token != null, "This method do not required token");
    }
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.delete(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          PathApi.urlApi,
          param == '' ? url : '$url/$param',
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.delete(
            /// PAKAI PARAMURL ATAU
            /// PAKAI PARAMS
            Uri.http(
              PathApi.urlApi,
              param == '' ? url : '$url/$param',
            ),
            headers: isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch delete api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses hapus data $e';
        return apiResponseModelError;
      } else {
        log('Error catch delete api provider $e');

        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }

  @override
  //
  /// ini sudah dengan URL API -> dotenv.env[URL_API]
  /// jadi pada https sudah -> Uri.https(PathApi.urlApi,url,)
  /// contoh :
  ///
  /// PathApi.url = bimsasaktisanjaya-ketut.com
  ///
  /// url = /api/v1/get
  ///
  /// jadi pada https hasilnya adalah
  /// bimsasaktisanjaya-ketut.com/api/v1/get
  ///
  /// jika ingin custom url api pakai [getCustomUrl]
  Future<ApiResponseModel> get(
    String url, {
    bool isUseToken = false,
    String? paramUrl = '',
    Map<String, dynamic>? params,
    String? token = '',
  }) async {
    // TODO: implement get
    if (isUseToken) {
      assert(token == null, "required token");
    } else {
      assert(token != null, "This method do not required token");
    }
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.get(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          PathApi.urlApi,
          paramUrl == '' ? url : '$url/$paramUrl',
          params,
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }
      log('data decode : $dataDecode');

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.get(
            /// PAKAI PARAMURL ATAU
            /// PAKAI PARAMS
            Uri.http(
              PathApi.urlApi,
              paramUrl == '' ? url : '$url/$paramUrl',
              params,
            ),
            headers: !isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch get api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses ambil data $e';
        return apiResponseModelError;
      } else {
        log('Error catch get api provider $e');

        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }

  @override
  Future<ApiResponseModel> post(
    String url, {
    bool isUseToken = false,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    log("kenapa ??");
    if (isUseToken) {
      assert(token == null, "required token");
    } else if (isUseToken == false) {
      assert(token == null, "This method do not required token");
    }
    // TODO: implement post
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.post(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          PathApi.urlApi,
          url,
          params,
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
        body: body,
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.post(
            /// PAKAI PARAMS
            Uri.http(
              PathApi.urlApi,
              url,
              params,
            ),
            headers: !isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch post api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses kirim data $e';
        return apiResponseModelError;
      } else {
        log('Error catch post api provider ha $e');

        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }

  @override
  Future<ApiResponseModel> put(
    String url, {
    bool isUseToken = false,
    Map<String, dynamic>? body,
    String? token,
    String? param,
  }) async {
    if (isUseToken) {
      assert(token == null, "required token");
    } else {
      assert(token != null, "This method do not required token");
    }
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.put(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          PathApi.urlApi,
          param == '' ? url : '$url/$param',
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
        body: body,
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.put(
            /// PAKAI PARAMS
            Uri.http(
              PathApi.urlApi,
              param == '' ? url : '$url/$param',
            ),
            headers: !isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch put api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses ubah data $e';
        return apiResponseModelError;
      } else {
        log('Error catch put api provider $e');
        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }

  @override
  Future<ApiResponseModel> deleteCustomUrl(
    String baseUrl,
    String url, {
    bool isUseToken = false,
    String? token,
    String? param,
  }) async {
    if (isUseToken) {
      assert(token == null, "required token");
    } else {
      assert(token != null, "This method do not required token");
    }
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.delete(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          baseUrl,
          param == '' ? url : '$url/$param',
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.delete(
            /// PAKAI PARAMURL ATAU
            /// PAKAI PARAMS
            Uri.http(
              baseUrl,
              param == '' ? url : '$url/$param',
            ),
            headers: isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch delete api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses hapus data $e';
        return apiResponseModelError;
      } else {
        log('Error catch delete api provider $e');

        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }

  @override
  Future<ApiResponseModel> getCustomUrl(
    String url,
    String baseUrl, {
    bool isUseToken = false,
    String? paramUrl,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    // TODO: implement get with custom url
    if (isUseToken) {
      assert(token == null, "required token");
    } else {
      assert(token != null, "This method do not required token");
    }
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.get(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          baseUrl,
          paramUrl == '' ? url : '$url/$paramUrl',
          params,
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }
      log('data decode : $dataDecode');

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.get(
            /// PAKAI PARAMURL ATAU
            /// PAKAI PARAMS
            Uri.http(
              baseUrl,
              paramUrl == '' ? url : '$url/$paramUrl',
              params,
            ),
            headers: !isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch get api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses ambil data $e';
        return apiResponseModelError;
      } else {
        log('Error catch get api provider $e');

        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }

  @override
  Future<ApiResponseModel> postCustomUrl(
    String url,
    String baseUrl, {
    bool isUseToken = false,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    // TODO: implement postCustomUrl
    if (isUseToken) {
      assert(token == null, "required token");
    } else {
      assert(token != null, "This method do not required token");
    }
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.post(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          baseUrl,
          url,
          params,
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
        body: body,
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.post(
            /// PAKAI PARAMS
            Uri.http(
              baseUrl,
              url,
              params,
            ),
            headers: !isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch post api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses kirim data $e';
        return apiResponseModelError;
      } else {
        log('Error catch post api provider ha $e');

        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }

  @override
  Future<ApiResponseModel> putCustomUrl(
    String url,
    String baseUrl, {
    bool isUseToken = false,
    Map<String, dynamic>? body,
    String? token,
    String? param,
  }) async {
    if (isUseToken) {
      assert(token == null, "required token");
    } else {
      assert(token != null, "This method do not required token");
    }
    try {
      //**
      // INI UNTUK HTTPS
      // */
      var response = await http.put(
        /// PAKAI PARAMURL ATAU
        /// PAKAI PARAMS
        Uri.https(
          baseUrl,
          param == '' ? url : '$url/$param',
        ),
        headers: !isUseToken
            ? null
            : {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
        body: body,
      );
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiResponseModel.errorFromJson(dataDecode);
      }

      return _parseResponse(dataDecode);
    } catch (e) {
      if (e is HandshakeException) {
        //**
        // INI UNTUK HTTP
        // */
        log('MASUK PADA HTTP');
        try {
          http.Response response = await http.put(
            /// PAKAI PARAMS
            Uri.http(
              baseUrl,
              param == '' ? url : '$url/$param',
            ),
            headers: !isUseToken
                ? null
                : {
                    HttpHeaders.authorizationHeader: 'Bearer $token',
                  },
          );
          Map<String, dynamic> dataDecode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            return ApiResponseModel.errorFromJson(dataDecode);
          }

          return ApiResponseModel.fromJson(dataDecode);
        } catch (e) {
          log('Error catch put api provider ha $e');

          apiResponseModelError.message = "Terjadi kesalahan : $e";
          return apiResponseModelError;
        }
      } else if (e is SocketException) {
        apiResponseModelError.message =
            'Tidak ada internet pada proses ubah data $e';
        return apiResponseModelError;
      } else {
        log('Error catch put api provider $e');
        apiResponseModelError.message = 'Error berasal dari server : $e';
        return apiResponseModelError;
      }
    }
  }
}
