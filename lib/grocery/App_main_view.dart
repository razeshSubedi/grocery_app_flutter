import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/grocery/home/bloc/home_bloc.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_app/grocery/home/ui/home_page.dart';

class AppMainView extends StatelessWidget {
  final String userId;

  const AppMainView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc(userId: userId)),
        BlocProvider(create: (_) => CartBloc(userId: userId)),
        BlocProvider(create: (_) => WishlistBloc()),
      ],
      child: HomePage(),
    );
  }
}