part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class SignUpSucessState extends AuthState{
  final String name;

  SignUpSucessState({required this.name});
}

final class SignUpFailureState extends AuthState{
  final String faliureMessage;

  SignUpFailureState({required this.faliureMessage});
}

final class LogInSucessState extends AuthState{}

final class LogInFailureState extends AuthState{}

final class AuthLoadingState extends AuthState{}
