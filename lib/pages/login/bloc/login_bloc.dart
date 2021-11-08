import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_eyes_of_rovers/core/services/services.dart';
import 'package:flutter_eyes_of_rovers/core/utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : _authService = getIt<AuthService>(),
        super(const LoginInitial()) {
    on<LoginWithFacebookRequested>((event, emit) async {
      emit(const LoginRequestInProgress());

      try {
        await _authService.signInWithFacebook();
        emit(const LoginRequestSuccess());
      } on Exception catch (error) {
        emit(LoginRequestFailure(error));
      }
    });
  }

  final AuthService _authService;
}
