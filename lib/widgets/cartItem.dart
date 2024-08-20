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
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(6.0),
        title: Text(
          productTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
        ),
        leading: ClipOval(
          child: Image.asset(
            "assets/images/product.jpg",
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        subtitle: Text(
          "$productPrice so'm",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.green[700],
                fontWeight: FontWeight.w600,
              ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.redAccent),
              onPressed: _decrementQuantity,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(
                    12.0), // Совпадает с радиусом карточки
              ),
              child: Text(
                '$productCount',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.blueAccent),
              onPressed: _incrementQuantity,
            ),
          ],
        ),
      ),
    );
  }
}
