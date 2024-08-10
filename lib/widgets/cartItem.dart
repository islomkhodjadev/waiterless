import "package:flutter/material.dart";

class CartItem extends StatefulWidget {
  final String productTitle;
  final double productPrice;
  final int productCount;

  const CartItem(
      {super.key,
      required this.productTitle,
      required this.productCount,
      required this.productPrice});

  @override
  State<CartItem> createState() {
    return _CartItem();
  }
}

class _CartItem extends State<CartItem> {
  String productTitle = "";
  double productPrice = 0.0;
  int productCount = 0;

  void _decrementQuantity() {}
  void _incrementQuantity() {}

  @override
  void initState() {
    super.initState();
    productCount = widget.productCount;
    productPrice = widget.productPrice;
    productTitle = widget.productTitle;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(productTitle),
      leading: ClipOval(
        child: Image.asset(
          "assets/images/product.jpg",
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      subtitle: Text("$productPrice so'm"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrementQuantity,
          ),
          Text('$productCount'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _incrementQuantity,
          ),
        ],
      ),
    );
  }
}
