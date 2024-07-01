import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';

abstract class RemoteDataSource {
  Future<ReturnResponse> getVendorWithComplaintCount();
  Future<ReturnResponse> login(String phone, String password);
  Future<ReturnResponse> autoLogin();
  Future<ReturnResponse> createComplaint({required String idVendor});
}
