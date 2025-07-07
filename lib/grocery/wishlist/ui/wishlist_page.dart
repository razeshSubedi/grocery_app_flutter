import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_app/grocery/wishlist/ui/wishlist_page_content_tile.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistBloc>().add(WishlistInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Wishlist"),
        backgroundColor: Colors.blueGrey,
      ),

      body: BlocConsumer<WishlistBloc, WishlistState>(
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          if (state is WishlistItemRemovedStata) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${state.removedProduct} is removed from wishlist.",
                ),
              ),
            );
          } else if (state is WishlistItemCartedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.cartedItemName} added to the cart."),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WishlistLoadingState) {
            return AppLoadingIndicator();
          } else if (state is WishlistPageLoadedState) {
            

            return ListView.builder(
              itemCount: state.wishlistedProducts.length,
              itemBuilder: (context, index) {
                return WishlistPageContentTile(
                  product: state.wishlistedProducts[index],
                  wishlistBloc: context.read<WishlistBloc>(),
                );
              },
            );
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Wishlist is empty.\n ")],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
