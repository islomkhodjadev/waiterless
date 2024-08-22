import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:waiterless/models/cartItemData.dart';
import 'package:waiterless/widgets/cardModal.dart';

class BottomBarWithBlur extends StatelessWidget {
  final int totalItemCount;
  final double totalPrice;
  List<Map<String, dynamic>> orders;

  BottomBarWithBlur({
    required this.totalItemCount,
    required this.totalPrice,
    required this.orders,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return totalItemCount > 0
        ? InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CartModal(orders: orders);
                },
              );
            },
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  color: Colors.green.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Are you sure? You don\'t want to order anything else?'),
                              action: SnackBarAction(
                                label: 'Yes',
                                onPressed: () async {
                                  for (int i = 0; i < orders.length; i++) {
                                    var item = await CartItemData.getCartItem(
                                        orders[i]["id"]);
                                    if (item == null) {
                                      CartItemData.addCartItem(CartItemData(
                                          productId: orders[i]["id"],
                                          productCount: 1,
                                          totalPrice: orders[i]["price"],
                                          productName: orders[i]["name"]));
                                    } else {
                                      CartItemData.addCartItem(CartItemData(
                                          productId: orders[i]["id"],
                                          productCount: (item.productCount + 1),
                                          totalPrice: orders[i]["price"],
                                          productName: orders[i]["name"]));
                                    }
                                  }

                                  Navigator.pushReplacementNamed(
                                      context, "/cart");
                                },
                              ),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Order',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
