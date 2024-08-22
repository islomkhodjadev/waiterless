import "package:flutter/material.dart";
import "package:waiterless/widgets/appbar.dart";
import "package:waiterless/widgets/cafeBranchCart.dart";
import "package:waiterless/data.dart";

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cafeBranches = cafebranches;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
          title: "Cafes",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: cafebranches.length,
            itemBuilder: (context, index) {
              var currentCafeBracnh = cafeBranches[index];
              return Cafebranchcart(
                  id: currentCafeBracnh["id"],
                  description: currentCafeBracnh["description"],
                  name: currentCafeBracnh["name"],
                  image: currentCafeBracnh["image"]);
            },
          ),
        ));
  }
}
