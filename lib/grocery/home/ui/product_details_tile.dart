import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/grocery/models/data_model.dart';
import 'package:grocery_app/grocery/home/bloc/home_bloc.dart';


class ProductDetailsTile extends StatelessWidget {
  final HomeBloc homeBloc;
  final ProductsDataModel productsDataModel;
  const ProductDetailsTile({
    super.key,
    required this.productsDataModel,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    productsDataModel.imageUrl,
                  ),
                ),
                borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            productsDataModel.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Category : ${productsDataModel.category}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price : \$${productsDataModel.price}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(WishlistButtonClicked(
                        clickedWishlistItem: productsDataModel,
                      ));
                    },
                    icon: Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(CartButtonClicked(
                        clickedCartItem: productsDataModel,
                      ));
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
