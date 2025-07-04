import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/Auth/Bloc/auth_bloc.dart';

import 'package:grocery_app/Auth/ui/sign_up.dart';
import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/App_main_view.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/home/bloc/home_bloc.dart';
import 'package:grocery_app/grocery/home/ui/home_page.dart';
import 'package:grocery_app/grocery/wishlist/bloc/wishlist_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogInFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.faliureMessage)));
          } else if (state is LogInSucessState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("login sucessful")));
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => AppMainView(userId: state.userId),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return AppLoadingIndicator();
          } else if (state is AuthInitialState) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusColor: Colors.blue,
                                      hoverColor: Colors.black,
                                      label: Text("Email"),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Email is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    obscureText: true,
                                    controller: _passwdController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusColor: Colors.blue,
                                      hoverColor: Colors.black,
                                      label: Text("Password"),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        context.read<AuthBloc>().add(
                                          LogInButtonClickedevent(
                                            email: _emailController.text.trim(),
                                            password: _passwdController.text
                                                .trim(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "The form is not valid, try again!",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text("Log In"),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't have an account?."),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage(),
                                            ),
                                          );
                                        },
                                        child: Text("Sign Up"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
