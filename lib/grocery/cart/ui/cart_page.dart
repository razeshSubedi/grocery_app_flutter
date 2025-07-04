import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/cart/ui/cart_page_product_details_tile.dart';

import 'package:grocery_app/grocery/home/ui/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartBloc>().add(CartInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: BlocConsumer<CartBloc, CartState>(
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartItemRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.productName} is removed from the cart."),
              ),
            );
          } else if (state is CartItemWishlistedState) {
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
              return Center(child: CircularProgressIndicator(value: 20));

            case CartSucessState:
            
              final cartSucessState = state as CartSucessState;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartSucessState.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartPageProductDetailsTile(
                          cartBloc: context.read<CartBloc>(),
                          productsDataModel: cartSucessState.cartItems[index],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Total Price: ",
                        ), // You can calculate and add price logic here
                      ],
                    ),
                  ),
                ],
              );

            case CartEmptyState:
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("The cart is empty."),
                      TextButton(
                        onPressed: () {
                         Navigator.pop(context);
                        },
                        child: Text(
                          "Click here to add items.",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              );

            default:
              return Center(child: Text("Error in cartpagestate"));
          }
        },
      ),
    );
  }
}
