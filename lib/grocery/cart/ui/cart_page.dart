import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/cart/ui/loaded_cart_page.dart';
import 'package:grocery_app/grocery/home/ui/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartItemRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.productName} is removed from the cart."),
              ),
            );
          }
          else if (state is CartItemWishlistedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.wishlistedItemName} is wishlisted."),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  value: 20,
                ),
              );

            case CartSucessState:
              final cartSucessState = state as CartSucessState;
              return LoadedCartPage(cartSucessState: cartSucessState, cartBloc: cartBloc);

            case CartEmptyState:
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "The cart is empty.",
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          "Click here to add items.",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );

            default:
              return Center(
                child: Text("Error in cartpagestate"),
              );
          }
        },
      ),
    );
  }
}
