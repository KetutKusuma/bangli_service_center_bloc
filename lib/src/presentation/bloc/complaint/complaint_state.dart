part of 'complaint_bloc.dart';

sealed class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object> get props => [];
}

final class ComplaintInitial extends ComplaintState {
  const ComplaintInitial();
}

final class ComplaintLoading extends ComplaintState {
  const ComplaintLoading();
}

final class ComplaintFailed extends ComplaintState {
  final ReturnResponse returnResponse;

  const ComplaintFailed({required this.returnResponse});
}

final class ComplaintSuccess extends ComplaintState {
  final ReturnResponse returnResponse;

  const ComplaintSuccess({required this.returnResponse});
}
