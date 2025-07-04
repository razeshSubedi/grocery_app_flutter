import 'package:flutter/material.dart';
import 'package:grocery_app/grocery/models/data_model.dart';
import 'package:grocery_app/grocery/wishlist/bloc/wishlist_bloc.dart';


class WishlistPageContentTile extends StatelessWidget {
  final WishlistBloc wishlistBloc;
  final ProductsDataModel product;
  const WishlistPageContentTile({
    super.key,
    required this.product,
    required this.wishlistBloc,
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
                    product.imageUrl,
                  ),
                ),
                borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Category : ${product.category}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price : \$${product.price}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                      )),
                  IconButton(
                      onPressed: () {
                        wishlistBloc.add(WishlistItemRemovedEvent(removedItem: product));
                      },
                      icon: Icon(
                        Icons.delete_outline,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
