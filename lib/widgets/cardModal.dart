import 'package:flutter/material.dart';
import 'package:waiterless/models/cartItemData.dart';
import 'package:waiterless/widgets/cartItem.dart';

class CartModal extends StatelessWidget {
  List<Map<String, dynamic>> orders;

  CartModal({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Your Cart",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300.0,
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return CartItem(
                  name: orders[index]["name"],
                  productCount: orders[index]["count"],
                  price: orders[index]["price"],
                  image: orders[index]["image"],
                  id: orders[index]["id"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
