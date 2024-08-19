import 'package:flutter/material.dart';
import 'package:waiterless/widgets/cartItem.dart';

class CartModal extends StatelessWidget {
  const CartModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Your Cart",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 300.0, // Adjust the height according to your needs
            child: ListView.builder(
              itemCount: 5, // Assuming cartItems is a list of CartItem objects
              itemBuilder: (context, index) {
                return const CartItem(
                  productTitle: "Cafee",
                  productCount: 5,
                  productPrice: 5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
