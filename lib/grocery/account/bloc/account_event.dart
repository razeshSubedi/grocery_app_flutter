part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

final class AccountInitialEvent extends AccountEvent {}

final class AccountDeleteEvent extends AccountEvent {}

final class AccountLogoutEvent extends AccountEvent {}
