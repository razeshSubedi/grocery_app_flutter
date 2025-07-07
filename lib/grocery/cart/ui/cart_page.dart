import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/cart/ui/cart_page_product_details_tile.dart';

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
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.blueGrey,
      ),

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
          if (state is CartLoadingState) {
            return AppLoadingIndicator();
          } else if (state is CartSucessState) {
            
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartPageProductDetailsTile(
                        cartBloc: context.read<CartBloc>(),
                        cartItemModel: state.cartItems[index],
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
          } else if (state is CartEmptyState) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("The cart is empty.")],
                ),
              ),
            );
          } else {
            return Center(child: Text("Error in cartpagestate"));
          }
        },
      ),
    );
  }
}
