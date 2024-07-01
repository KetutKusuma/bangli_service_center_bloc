part of 'complaint_bloc.dart';

sealed class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object> get props => [];
}

class CreateComplaintEvent extends ComplaintEvent {
  final String id;

  const CreateComplaintEvent({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
