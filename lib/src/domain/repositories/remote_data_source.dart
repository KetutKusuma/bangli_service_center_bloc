import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';

abstract class RemoteDataSource {
  Future<ReturnResponseModel> getVendorWithComplaintCount();
  Future<ReturnResponseModel> login(String phone, String password);
  Future<ReturnResponseModel> autoLogin();
}
