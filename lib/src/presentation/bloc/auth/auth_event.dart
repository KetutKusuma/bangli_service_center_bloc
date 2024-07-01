part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String phone;
  final String password;

  LoginEvent({required this.phone, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [phone, password];
}

class AutoLoginEvent extends AuthEvent {}
