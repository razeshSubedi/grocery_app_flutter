part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class SignUpSucessState extends AuthState{
  final String name;
  final String userId;

  SignUpSucessState({required this.name,required this.userId});
}

final class SignUpFailureState extends AuthState{
  final String faliureMessage;

  SignUpFailureState({required this.faliureMessage});
}

final class LogInSucessState extends AuthState{
  final String userId;

  LogInSucessState({required this.userId});
}

final class LogInFailureState extends AuthState{
  final String faliureMessage;

  LogInFailureState({required this.faliureMessage});

}

final class AuthLoadingState extends AuthState{}
