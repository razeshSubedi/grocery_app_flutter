import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/common/widgets/app_loading_screen.dart';
import 'package:grocery_app/grocery/home/bloc/home_bloc.dart';
import 'package:grocery_app/grocery/home/ui/product_details_tile.dart';
import 'package:grocery_app/grocery/models/data_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Store"),
        backgroundColor: Colors.blueGrey,
      ),

      body: BlocConsumer<HomeBloc, HomeState>(
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
            final categorizedProducts = <String, List<ProductsDataModel>>{};
            for (var product in state.products) {
              categorizedProducts
                  .putIfAbsent(product.category, () => [])
                  .add(product);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search products...",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (query) {
                            context.read<HomeBloc>().add(
                              HomeSearchEvent(query: query),
                            );
                          },
                        ),
                      ),
                      ...categorizedProducts.entries.map((entry) {
                        final category = entry.key;
                        final products = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 12,
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 240,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return ProductDetailsTile(
                                    homeBloc: context.read<HomeBloc>(),
                                    productsDataModel: products[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is HomeErrorState) {
            return Center(child: Text("There was a Homepage loading error."));
          } else {
            return Center(child: Text("Error-homepage"));
          }
        },
      ),
    );
  }
}
