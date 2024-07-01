import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/domain/repositories/remote_data_source.dart';

class LogInCase {
  final RemoteDataSource remoteDataSource;

  LogInCase(this.remoteDataSource);

  Future<ReturnResponse> call(String phone, String password) async {
    return await remoteDataSource.login(phone, password);
  }
}
