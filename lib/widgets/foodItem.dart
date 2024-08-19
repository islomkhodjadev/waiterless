import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {
  final Function(int, int) onCountChange;

  const FoodItem({super.key, required this.onCountChange});

  @override
  State<FoodItem> createState() {
    return _FoodItem();
  }
}

class _FoodItem extends State<FoodItem> {
  int count = 0;
  void _showDescriptionModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Full Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Here is the detailed description of the cafe product. You can provide more info here such as ingredients, nutritional facts, etc.",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDescriptionModal, // Attach the modal functionality here
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Stretches the column to fill Card width
          children: [
            Padding(
              padding: EdgeInsets.all(8.0), // Adds padding around the text
              child: Text(
                "Cafee",
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Optional: makes text bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0), // Adds horizontal padding around the image
              child: AspectRatio(
                aspectRatio:
                    1.0, // Adjust the aspect ratio according to your image's aspect ratio
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        8.0), // Optional, if you want rounded corners
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8.0), // Matches the border's borderRadius
                    child: Image.asset(
                      "assets/images/product.jpg",
                      fit: BoxFit
                          .cover, // Ensures the image covers the space without changing aspect ratio
                    ),
                  ),
                ),
              ),
            ),
            Spacer(), // Adds flexible space between image and button
            Padding(
                padding: EdgeInsets.all(8.0),
                child: count == 0
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            count++;
                            widget.onCountChange(1, 12000);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .onPrimaryFixedVariant, // Background color of the button
                          foregroundColor: Colors.white, // Text color
                        ),
                        child: Text("Add +"),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // Decrease the count
                                if (count > 0) {
                                  count--;
                                  widget.onCountChange(-1, 1200);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryFixedVariant,
                              foregroundColor: Colors.white,
                            ),
                            child: Text("-"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "$count", // Display the current count
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // Increase the count
                                count++;
                                widget.onCountChange(1, 1200);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryFixedVariant,
                              foregroundColor: Colors.white,
                            ),
                            child: Text("+"),
                          ),
                        ],
                      )),
          ],
        ),
      ),
    );
  }
}
