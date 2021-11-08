part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginRequestInProgress extends LoginState {
  const LoginRequestInProgress();
}

class LoginRequestSuccess extends LoginState {
  const LoginRequestSuccess();
}

class LoginRequestFailure extends LoginState {
  const LoginRequestFailure(this.failure);

  final Exception failure;

  @override
  List<Object> get props => [failure];
}
