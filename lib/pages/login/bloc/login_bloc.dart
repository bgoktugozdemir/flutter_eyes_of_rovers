import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(const LoginInitial()) {
    on<LoginWithFacebookRequested>((event, emit) async {
      emit(const LoginRequestInProgress());
      try {
        await _authenticationRepository.signInWithFacebook();
        emit(const LoginRequestSuccess());
      } on Exception catch (error) {
        emit(LoginRequestFailure(error));
      }
    });
  }

  final AuthenticationRepository _authenticationRepository;
}
