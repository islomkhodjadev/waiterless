import "package:flutter/material.dart";
import "package:waiterless/models/cartItemData.dart";
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
  List<CartItemData> cartItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCafes();
  }

  void loadCafes() async {
    List<CartItemData> cafes = await CartItemData.getAllCartItems();

    setState(() {
      cartItems = cafes;
      print("here is the products list");
      print(cartItems);
      for (int i = 0; i < cartItems.length; i++) {
        print(cartItems[i].productCount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Shop Cart"),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        itemBuilder: (context, productIndex) {
          var currentProduct = cartItems[productIndex];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Dismissible(
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content:
                            const Text('Are you sure you want to delete it?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                key: Key(
                    "${currentProduct.productId}-${currentProduct.productName}"), // Unique key
                direction: DismissDirection.endToStart, // Swipe direction
                onDismissed: (direction) {
                  _removeProduct(productIndex);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${currentProduct.productName} removed')),
                  );
                },
                background: Container(
                  color: AppColors.lightRed,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerEnd,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: CartItem(
                  name: currentProduct.productName,
                  productCount: currentProduct.productCount,
                  price: currentProduct.totalPrice,
                  image: "assets/images/cafeimage.jpg",
                  id: currentProduct.productId,
                )),
          );
        },
      ),
    );
  }

  _removeProduct(int productIndex) {
    setState(() {
      cartItems.removeAt(productIndex);
    });
  }
}
