import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountInitialEvent>((event, emit) async {
      emit(AccountLoadingState());
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      print("got user");
      if (user == null) {
        throw Exception("user is not logged in");
      }
      final response = await supabase
          .from('profiles')
          .select('username')
          .eq('id', user.id)
          .single();

      print("gotname: ${response['username'].toString()}");

      emit(AccountLoadedState(userName: response['username'].toString()));
    });
  }
}
