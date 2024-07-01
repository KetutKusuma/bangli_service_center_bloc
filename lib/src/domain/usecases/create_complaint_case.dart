import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/domain/repositories/remote_data_source.dart';

class CreateComplaintCase {
  final RemoteDataSource remoteDataSource;

  CreateComplaintCase(this.remoteDataSource);

  Future<ReturnResponse> call({required String idVendor}) async {
    return await remoteDataSource.createComplaint(idVendor: idVendor);
  }
}
