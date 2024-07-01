import '../../../../core/return_response/return_response.dart';

abstract class ApiDataSource {
  Future<ReturnResponse> getVendorWithComplaintCount();
  Future<ReturnResponse> login(
      {required String phone, required String password});
  Future<ReturnResponse> autoLogin();
  Future<ReturnResponse> getUserDetail();
  Future<ReturnResponse> createComplaint({required String idVendor});
}
