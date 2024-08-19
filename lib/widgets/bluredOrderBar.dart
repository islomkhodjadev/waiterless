import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:waiterless/widgets/cardModal.dart';

class BottomBarWithBlur extends StatelessWidget {
  final int totalItemCount;
  final int totalPrice;

  const BottomBarWithBlur({
    required this.totalItemCount,
    required this.totalPrice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure totalItemCount > 0 to display the bottom bar
    return totalItemCount > 0
        ? InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const CartModal(); // Assuming CartModal is defined elsewhere
                },
              );
            },
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  color: Colors.green
                      .withOpacity(0.5), // Semi-transparent green background
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                                onPressed: () {
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
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox
            .shrink(); // Return an empty widget when there's no item count
  }
}
