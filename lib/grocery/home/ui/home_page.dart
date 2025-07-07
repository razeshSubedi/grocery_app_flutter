import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/home/bloc/home_bloc.dart';
import 'package:grocery_app/grocery/home/ui/product_details_tile.dart';
import 'package:grocery_app/services/supabase_service.dart';

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

      SupabaseService().listenToProductChanges(() {
        context.read<HomeBloc>().add(HomeInitialFetchEvent());
      });
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
        if (state is ProductAddedToCartState) {
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
        if (state is HomeLoadingState) {
          return AppLoadingIndicator();
        } else if (state is HomeLoadingSucessState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Grocery store"),
              backgroundColor: Colors.blueGrey,
            ),
            body: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductDetailsTile(
                  homeBloc: context.read<HomeBloc>(),
                  productsDataModel: state.products[index],
                );
              },
            ),
          );
        } else if (state is HomeErrorState) {
          return Scaffold(
            body: Center(child: Text("There was a Homepage loading error.")),
          );
        } else {
          return Scaffold(body: Text("Error"));
        }
      },
    );
  }
}
