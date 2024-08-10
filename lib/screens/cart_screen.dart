import "package:flutter/material.dart";
import "package:waiterless/utils/colors.dart";
import "package:waiterless/widgets/appbar.dart";
import "package:waiterless/widgets/cartItem.dart";

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() {
    return _CartScreen();
  }
}

class _CartScreen extends State<CartScreen> {
  int _itemCount = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: "shop cart"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: _itemCount,
                itemBuilder: (context, index) {
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

                      key: const Key("salom"), // Unique key for each item
                      direction: DismissDirection.endToStart, // Swipe direction
                      onDismissed: (direction) {
                        _removeItem(index); // Remove the item from the list
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(' removed')),
                        );
                      },
                      background: Container(
                        color: AppColors.lightRed,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: CartItem(
                        productCount: 1,
                        productPrice: 1.2,
                        productTitle: "Latte",
                      ),
                    ),
                  );
                }),
          ),
        ));
  }

  _removeItem(int index) {
    setState(() {
      _itemCount = 0;
    });
  }
}
