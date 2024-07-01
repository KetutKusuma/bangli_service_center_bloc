import 'dart:developer';

import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/domain/usecases/create_complaint_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final CreateComplaintCase _createComplaintCase;

  ComplaintBloc(this._createComplaintCase) : super(ComplaintInitial()) {
    on<CreateComplaintEvent>(createComplaint);
  }

  Future<void> createComplaint(
      CreateComplaintEvent event, Emitter<ComplaintState> emit) async {
    emit(const ComplaintLoading());
    ReturnResponse r = await _createComplaintCase.call(idVendor: event.id);
    if (!r.status) {
      emit(ComplaintFailed(returnResponse: r));
    } else {
      emit(ComplaintSuccess(returnResponse: r));
    }
  }
}
