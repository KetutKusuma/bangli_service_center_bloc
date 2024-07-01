import '../api_response/api_response.dart';

/// AMBIL KODE DARI GUS ARI
/// MODIF BY KETUT
/// INTERFACE FOR API CALLS
/// AGAR TIDAK MEMBUAT FUNCTION GET/ POST/ PUT
/// DENGAN PARAM YANG BERBEDA (1 FUNCTIONALITY)
/// SESUAIKAN PARAM YANG DIBUTUHKAN
/// JIKA PERLU TOKEN TINGGAL ISI SAJA TOKEN
/// JIKA PAKAI PARAM TINGGAL ISI PARAM SAJA
/// JIKA PAKAI PARAMS TINGGAL ISI PARAMS SAJA

abstract class BaseApiImpl {
  // REUSEABLE METHOD
  // FOR GET
  Future<ApiResponseModel> get(
    String url, {
    bool isUseToken,
    String? paramUrl,
    Map<String, dynamic>? params,
    String? token,
  });

  /// REUSEABLE METHOD
  /// FOR POST
  Future<ApiResponseModel> post(
    String url, {
    bool isUseToken,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    String? token,
  });

  /// REUSEABLE METHOD
  /// FOR PUT
  Future<ApiResponseModel> put(
    String url, {
    bool isUseToken,
    Map<String, dynamic>? body,
    String? token,
    String? param,
  });

  /// REUSEABLE METHOD
  /// FOR DELETE
  Future<ApiResponseModel> delete(
    String url, {
    bool isUseToken,
    String? token,
    String? param,
  });

  // GET CUSTOM URL
  Future<ApiResponseModel> getCustomUrl(
    String baseUrl,
    String url, {
    bool isUseToken,
    String? paramUrl,
    Map<String, dynamic>? params,
    String? token,
  });

  // POST CUSTOM URL
  Future<ApiResponseModel> postCustomUrl(
    String baseUrl,
    String url, {
    bool isUseToken,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    String? token,
  });

  // PUT CUSTOM URL
  Future<ApiResponseModel> putCustomUrl(
    String baseUrl,
    String url, {
    bool isUseToken,
    Map<String, dynamic>? body,
    String? token,
    String? param,
  });

  // DELETE CUSTOM URL
  Future<ApiResponseModel> deleteCustomUrl(
    String baseUrl,
    String url, {
    bool isUseToken,
    String? token,
    String? param,
  });
}
