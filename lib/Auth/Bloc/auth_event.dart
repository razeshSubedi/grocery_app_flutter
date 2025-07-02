part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthInitialEvent extends AuthEvent {}

final class SignUpButtonClickedEvent extends AuthEvent {
  final String userName;
  final String email;
  final String phoneNumber;
  final String password;

  SignUpButtonClickedEvent(
      {required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.password});
}

final class LogInButtonClickedevent extends AuthEvent {
  final String email;
  final String password;

  LogInButtonClickedevent({
    required this.email,
    required this.password,
  });
}
