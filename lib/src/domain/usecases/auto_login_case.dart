import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/domain/repositories/remote_data_source.dart';

class AutoLoginCase {
  final RemoteDataSource remoteDataSource;

  AutoLoginCase(this.remoteDataSource);

  Future<ReturnResponseModel> call() async {
    return await remoteDataSource.autoLogin();
  }
}
