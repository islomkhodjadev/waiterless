import 'package:flutter/material.dart';
import 'package:waiterless/data.dart';
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
  double totalPrice = 0;
  List<Map<String, dynamic>> selectedFoods = [];

  void _updateSelectedFood(
      int id, String foodname, double changePrice, int change, String image) {
    int foodIndex = selectedFoods.indexWhere((food) => food["id"] == id);

    if (foodIndex != -1) {
      selectedFoods[foodIndex]['count'] += 1;
    } else {
      selectedFoods.add({
        'name': foodname,
        'price': changePrice,
        'id': id,
        "count": change,
        "image": image
      });
    }
  }

  void _Counter(
      int id, int change, double changePrice, String foodName, String image) {
    setState(() {
      totalItemCount += change;
      totalPrice += (changePrice * change);

      if (change > 0) {
        _updateSelectedFood(id, foodName, changePrice, change, image);
      } else {
        selectedFoods.removeWhere((food) => food['name'] == foodName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = categoryAndProducts;

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
                  categories[categoryIndex]['name'],
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 24.0,
                      ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.68,
                ),
                itemCount: categories[categoryIndex]['products'].length,
                itemBuilder: (context, itemIndex) {
                  var currentproduct =
                      categories[categoryIndex]['products'][itemIndex];
                  return FoodItem(
                    id: currentproduct["id"],
                    description: currentproduct["description"],
                    image: currentproduct["image"],
                    name: currentproduct["name"],
                    price: currentproduct["price"],
                    onCountChange: (change, changePrice) {
                      _Counter(currentproduct["id"], change, changePrice,
                          currentproduct["name"], currentproduct["image"]);
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomBarWithBlur(
        totalItemCount: totalItemCount,
        totalPrice: totalPrice,
        orders: selectedFoods,
      ),
    );
  }
}
