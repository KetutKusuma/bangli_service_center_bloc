import '../../../../core/return_response/return_response.dart';

abstract class ApiDataSource {
  Future<ReturnResponseModel> getVendorWithComplaintCount();
  Future<ReturnResponseModel> login(
      {required String phone, required String password});
  Future<ReturnResponseModel> autoLogin();
  Future<ReturnResponseModel> getUserDetail();
}
