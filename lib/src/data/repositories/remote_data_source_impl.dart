import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/remote_data/api_data_source.dart';
import 'package:bangli_service_center_bloc/src/domain/repositories/remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiDataSource apiDataSource;

  RemoteDataSourceImpl(this.apiDataSource);

  @override
  Future<ReturnResponseModel> getVendorWithComplaintCount() async {
    return await apiDataSource.getVendorWithComplaintCount();
  }

  @override
  Future<ReturnResponseModel> login(String phone, String password) async {
    return await apiDataSource.login(phone: phone, password: password);
  }

  @override
  Future<ReturnResponseModel> autoLogin() async {
    return await apiDataSource.autoLogin();
  }
}
