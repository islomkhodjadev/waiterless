import "package:flutter/material.dart";
import "package:waiterless/widgets/appbar.dart";
import "package:waiterless/widgets/cafeBranchCart.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
          title: "Cafes",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Cafebranchcart();
            },
          ),
        ));
  }
}
