import 'package:flutter/material.dart';
import 'package:grocery_app/Auth/ui/login_page.dart';
import 'package:grocery_app/Auth/ui/sign_up.dart';
import 'package:grocery_app/landing/landing_page_product_tile.dart';
import 'package:grocery_app/services/supabase_service.dart';
import 'package:grocery_app/grocery/models/data_model.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Store"),
        backgroundColor: Colors.blueGrey,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ),
            child: const Text("Login", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            ),
            child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: FutureBuilder<List<ProductsDataModel>>(
        future: SupabaseService().fetchAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to load products."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products available."));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductTileForLanding(
                productsDataModel: products[index],
                onRedirect: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => BlocProvider.value(
                //       value: context.read<AuthBloc>(),
                //       child: LoginPage(),
                //     ),
                //   ),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
