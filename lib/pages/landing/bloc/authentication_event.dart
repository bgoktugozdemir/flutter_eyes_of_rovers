part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationSignOutRequested extends AuthenticationEvent {
  const AuthenticationSignOutRequested();
}

class AuthenticationUserChanged extends AuthenticationEvent {
  @visibleForTesting
  const AuthenticationUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
