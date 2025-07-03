import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//subedirajesh787@gmail.com

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseClient supabase;
  AuthBloc({required this.supabase}) : super(AuthInitialState()) {
    on<SignUpButtonClickedEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());

        final check = await supabase
            .from('profiles')
            .select('id')
            .eq('email', event.email)
            .maybeSingle();

        if (check != null) {
          emit(SignUpFailureState(faliureMessage: "The email already exists!"));
        } else {
          final response = await supabase.auth.signUp(
            email: event.email,
            password: event.password,
          );

          final userId = response.user!.id;
          if (response.user != null) {
            await supabase.from("profiles").upsert({
              'id': userId,
              'username': event.userName,
              "email": event.email,
              "phone": event.phoneNumber,
            });
            
            final nameOfUser = await supabase
                .from('profiles')
                .select('username')
                .eq('id', userId);

            emit(SignUpSucessState(name: nameOfUser.toString()));
          } else {
            emit(
              SignUpFailureState(
                faliureMessage: "An unexpected error occured.",
              ),
            );
          }
        }
      } catch (error) {
        emit(SignUpFailureState(faliureMessage: error.toString()));
      }
    });

    on<AuthInitialEvent>((event, emit) {
      emit(AuthInitialState());
    });
    on<LogInButtonClickedevent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final response = await supabase.auth.signInWithPassword(
          password: event.password,
          email: event.email,
        );

        if (response.user != null) {
          emit(LogInSucessState());
        } else {
          emit(
            LogInFailureState(
              faliureMessage: "An unexpected error inside bloc",
            ),
          );
        }
      } catch (error) {
        emit(LogInFailureState(faliureMessage: error.toString()));
      }
    });
  }
}
