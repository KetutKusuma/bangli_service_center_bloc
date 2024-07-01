part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthFailure extends AuthState {
  final ReturnResponse returnResponse;

  const AuthFailure({required this.returnResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [returnResponse];
}

final class AuthSuccess extends AuthState {
  final ReturnResponse returnResponse;

  const AuthSuccess({required this.returnResponse});
  @override
  // TODO: implement props
  List<Object?> get props => [returnResponse];
}
