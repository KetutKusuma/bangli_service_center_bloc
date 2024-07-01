import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/domain/usecases/auto_login_case.dart';
import 'package:bangli_service_center_bloc/src/domain/usecases/login_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInCase _logInCase;
  final AutoLoginCase _autoLoginCase;

  AuthBloc({required LogInCase logInCase, required AutoLoginCase autoLoginCase})
      : _logInCase = logInCase,
        _autoLoginCase = autoLoginCase,
        super(const AuthInitial()) {
    on<LoginEvent>(loginnn);
    on<AutoLoginEvent>(autologinnn);
  }

  Future<void> loginnn(
    LoginEvent loginEvent,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    ReturnResponse r =
        await _logInCase.call(loginEvent.phone, loginEvent.password);
    if (r.status == false) {
      return emit(AuthFailure(returnResponse: r));
    }

    return emit(AuthSuccess(returnResponse: r));
  }

  Future<void> autologinnn(
      AutoLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    ReturnResponse r = await _autoLoginCase.call();

    if (r.status == false) {
      return emit(AuthFailure(returnResponse: r));
    }

    return emit(AuthSuccess(returnResponse: r));
  }
}
