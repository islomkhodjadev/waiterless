import "package:flutter/material.dart";
import "package:waiterless/utils/colors.dart";
import "package:waiterless/widgets/appbar.dart";
import "package:waiterless/widgets/cartItem.dart";

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() {
    return _CartScreen();
  }
}

class _CartScreen extends State<CartScreen> {
  List<Map<String, dynamic>> _cafes = [
    {
      'cafeName': 'Cafe A',
      'products': [
        {'productTitle': 'Latte', 'productPrice': 5.0, 'productCount': 2},
        {'productTitle': 'Espresso', 'productPrice': 3.0, 'productCount': 1},
      ]
    },
    {
      'cafeName': 'Cafe B',
      'products': [
        {'productTitle': 'Cappuccino', 'productPrice': 4.5, 'productCount': 1},
        {'productTitle': 'Mocha', 'productPrice': 6.0, 'productCount': 1},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Shop Cart"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _cafes.length,
            itemBuilder: (context, cafeIndex) {
              var cafe = _cafes[cafeIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cafe Name
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      cafe['cafeName'],
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  // List of products for this cafe
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cafe['products'].length,
                    itemBuilder: (context, productIndex) {
                      var product = cafe['products'][productIndex];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text(
                                      'Are you sure you want to delete it?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          key: Key(
                              "${cafe['cafeName']}-${product['productTitle']}"), // Unique key
                          direction:
                              DismissDirection.endToStart, // Swipe direction
                          onDismissed: (direction) {
                            _removeProduct(cafeIndex, productIndex);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${product['productTitle']} removed')),
                            );
                          },
                          background: Container(
                            color: AppColors.lightRed,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: AlignmentDirectional.centerEnd,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: CartItem(
                            productTitle: product['productTitle'],
                            productCount: product['productCount'],
                            productPrice: product['productPrice'],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _removeProduct(int cafeIndex, int productIndex) {
    setState(() {
      _cafes[cafeIndex]['products'].removeAt(productIndex);
      if (_cafes[cafeIndex]['products'].isEmpty) {
        _cafes.removeAt(cafeIndex); // Remove cafe if no products left
      }
    });
  }
}
