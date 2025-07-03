import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/models/data_model.dart';

class CartPageProductDetailsTile extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductsDataModel productsDataModel;
  const CartPageProductDetailsTile({
    super.key,
    required this.productsDataModel,
    required this.cartBloc,
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
                        cartBloc.add(CartItemWishlistedEvent(wishlistedItem: productsDataModel));
                      },
                      icon: Icon(
                        Icons.favorite_outline,
                      )),
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartRemoveItemEvent(cartItemToBeDeleted: productsDataModel));
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
