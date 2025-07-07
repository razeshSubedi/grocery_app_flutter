part of 'account_bloc.dart';

@immutable
sealed class AccountState {}
final class AccountInitial extends AccountState{}

final class AccountLoadedState extends AccountState {
  final String userName;

  AccountLoadedState({required this.userName});
}
final class AccountLoadingState extends AccountState{}
final class AccountLoggedOutState extends AccountState {}

final class AccountLogOutFailureState extends AccountState {}

final class AccountDeletedState extends AccountState {}

final class AcccountDeletionFailureState extends AccountState {}
