import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/account/bloc/account_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountBloc>().add(AccountInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Account"),

        backgroundColor: Colors.blueGrey,
      ),
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AccountLoadedState) {
            final String fullName = state.userName.toUpperCase();
            final String firstLetter = fullName.isNotEmpty ? fullName[0] : "?";
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Box
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            firstLetter,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text("Delivery Location"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text("Recent Purchases"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: const Text("My Orders"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: const Text("Delete Account"),
                    textColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Log Out"),
                    textColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: () {},
                  ),
                ],
              ),
            );
          } else if (state is AccountLoadingState) {
            return AppLoadingIndicator();
          } else {
            return Center(child: Text("unexpected error loading accountpage"));
          }
        },
      ),
    );
  }
}
