import 'package:flutter/material.dart';
import 'package:grocery_app/grocery/cart/bloc/cart_bloc.dart';
import 'package:grocery_app/grocery/models/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPageProductDetailsTile extends StatefulWidget {
  final CartBloc cartBloc;
  final CartItemModel cartItemModel;
  final VoidCallback onQuantityChanged;

  const CartPageProductDetailsTile({
    super.key,
    required this.cartItemModel,
    required this.cartBloc,
    required this.onQuantityChanged,
  });

  @override
  State<CartPageProductDetailsTile> createState() =>
      _CartPageProductDetailsTileState();
}

class _CartPageProductDetailsTileState
    extends State<CartPageProductDetailsTile> {
  @override
  Widget build(BuildContext context) {
    final quantityController = TextEditingController(
      text: widget.cartItemModel.quantity.toString(),
    );

    return ListTile(
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          widget.cartItemModel.products.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        widget.cartItemModel.products.name,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Qty:", style: TextStyle(fontSize: 12)),
              SizedBox(width: 6),
              SizedBox(
                width: 40,
                height: 28,
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    int? newQty = int.tryParse(value);
                    if (newQty != null && newQty > 0) {
                      context.read<CartBloc>().add(
                        CartQuantityChangedEvent(
                          productId: widget.cartItemModel.products.id,
                          updatedQuantity: newQty,
                        ),
                      );
                      widget.onQuantityChanged();
                    } else {
                      print("error in cartdetails page- quantity selection");
                    }
                  },
                ),
              ),
              SizedBox(width: 6),
              Text(
                widget.cartItemModel.products.unit,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Text(
            "Price: \$${widget.cartItemModel.products.price.toStringAsFixed(2)} x ${widget.cartItemModel.quantity}",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: Colors.red, size: 22),
        onPressed: () {
          widget.cartBloc.add(
            CartRemoveItemEvent(cartItemToBeDeleted: widget.cartItemModel),
          );
        },
      ),
    );
  }
}
