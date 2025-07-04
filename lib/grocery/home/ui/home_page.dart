import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/cart/ui/cart_page.dart';
import 'package:grocery_app/grocery/home/bloc/home_bloc.dart';
import 'package:grocery_app/grocery/home/ui/product_details_tile.dart';
import 'package:grocery_app/grocery/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_app/grocery/wishlist/ui/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(HomeInitialFetchEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        return current is HomeActionState;
      },
      buildWhen: (previous, current) {
        return current is! HomeActionState;
      },
      listener: (context, state) {
        if (state is NavigateToCartPageState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<CartBloc>(),
                child: CartPage(),
              ),
            ),
          );
        } else if (state is NavigateToWishlistPageState) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => BlocProvider.value(
          //       value: context.read<WishlistBloc>(),
          //       child: WishlistPage(),
          //     ),
          //   ),

          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<WishlistBloc>(),
                child: WishlistPage(),
              ),
            ),
          );
        } else if (state is ProductAddedToCartState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ProductAddedToWishlistState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return AppLoadingIndicator();

          case HomeLoadingSucessState:
            final sucessState = state as HomeLoadingSucessState;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(
                        WishlistNavigationButtonClicked(),
                      );
                    },
                    icon: Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(
                        CartNavigationButtonClicked(),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
                title: Text("Grocery store"),
              ),
              body: ListView.builder(
                itemCount: sucessState.products.length,
                itemBuilder: (context, index) {
                  return ProductDetailsTile(
                    homeBloc: context.read<HomeBloc>(),
                    productsDataModel: sucessState.products[index],
                  );
                },
              ),
            );

          case HomeErrorState:
            return Scaffold(
              body: Center(child: Text("There was a Homepage loading error.")),
            );

          default:
            return Scaffold(body: Text("Error"));
        }
      },
    );
  }
}
