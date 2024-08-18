import 'package:flutter/material.dart';
import 'package:waiterless/widgets/appbar.dart';
import 'package:waiterless/widgets/foodItem.dart';

class CafeScreen extends StatefulWidget {
  @override
  _CafeScreenState createState() => _CafeScreenState();
}

class _CafeScreenState extends State<CafeScreen> {
  final List<dynamic> categories = [
    {
      'title': 'Drinks',
      'items': List.generate(6, (index) => FoodItem()), // 6 drink items
    },
    {
      'title': 'Snacks',
      'items': List.generate(4, (index) => FoodItem()), // 4 snack items
    },
    // Add more categories with items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Food"),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int categoryIndex) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categories[categoryIndex]['title'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      200.0, // Maximum width of an item in the grid
                  crossAxisSpacing: 10.0, // Horizontal space between items
                  mainAxisSpacing: 10.0, // Vertical space between items
                  childAspectRatio:
                      0.68, // Adjusted aspect ratio to better fit the content
                ),
                itemCount: categories[categoryIndex]['items'].length,
                itemBuilder: (context, itemIndex) {
                  return categories[categoryIndex]['items'][itemIndex];
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
