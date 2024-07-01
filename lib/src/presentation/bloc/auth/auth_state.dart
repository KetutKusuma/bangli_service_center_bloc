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
  final ReturnResponseModel returnResponseModel;

  const AuthFailure({required this.returnResponseModel});

  @override
  // TODO: implement props
  List<Object?> get props => [returnResponseModel];
}

final class AuthSuccess extends AuthState {
  final ReturnResponseModel returnResponseModel;

  const AuthSuccess({required this.returnResponseModel});
  @override
  // TODO: implement props
  List<Object?> get props => [returnResponseModel];
}
