import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/Auth/Bloc/auth_bloc.dart';

import 'package:grocery_app/Auth/ui/login_page.dart';
import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/app_main_view.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _phoneNumberController = TextEditingController();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwdController = TextEditingController();

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
          if (state is SignUpSucessState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => AppMainView(userId: state.userId),
              ),
              (route) => false,
            );
          } else if (state is SignUpFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.faliureMessage)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return AppLoadingIndicator();
          } else if (state is AuthInitialState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
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
                              controller: _nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusColor: Colors.blue,
                                hoverColor: Colors.black,
                                label: Text("Your name"),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Username is required";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusColor: Colors.blue,
                                hoverColor: Colors.black,
                                label: Text("Phone Number"),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Phone number is required";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
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
                                    SignUpButtonClickedEvent(
                                      userName: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwdController.text.trim(),
                                      phoneNumber: _phoneNumberController.text
                                          .trim()
                                          .toString(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "The form is not valid, try again!",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text("Sign Up"),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?."),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text("Log in."),
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
            );
          } else {
            return Scaffold(body: Center(child: Text("Some error occured")));
          }
        },
      ),
    );
  }
}
