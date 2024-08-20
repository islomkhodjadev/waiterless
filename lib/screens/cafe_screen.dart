import 'package:flutter/material.dart';
import 'package:waiterless/widgets/appbar.dart';
import 'package:waiterless/widgets/bluredOrderBar.dart';
import 'package:waiterless/widgets/foodItem.dart';

class CafeScreen extends StatefulWidget {
  const CafeScreen({super.key});

  @override
  _CafeScreenState createState() => _CafeScreenState();
}

class _CafeScreenState extends State<CafeScreen> {
  int totalItemCount = 0;
  int totalPrice = 0;

  void _Counter(int change, int changePrice) {
    setState(() {
      totalItemCount += change;
      totalPrice += (changePrice * change);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> categories = [
      {
        'title': 'Drinks',
        'items': List.generate(
          6,
          (index) => FoodItem(
            onCountChange: _Counter,
          ),
        ), // 6 drink items
      },
      {
        'title': 'Snacks',
        'items': List.generate(
          4,
          (index) => FoodItem(
            onCountChange: _Counter,
          ),
        ),
      },
    ];

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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 24.0,
                      ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.68,
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
      bottomNavigationBar: BottomBarWithBlur(
        totalItemCount: totalItemCount,
        totalPrice: totalPrice,
      ),
    );
  }
}
