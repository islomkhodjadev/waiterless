import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {
  final Function(int, double) onCountChange;
  final String name;
  final int id;
  final String description;
  final String image;
  final double price;

  const FoodItem(
      {super.key,
      required this.onCountChange,
      required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.price});

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
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Full Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
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
              padding:
                  const EdgeInsets.all(8.0), // Adds padding around the text
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.normal, // Optional: makes text bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
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
                      widget.image,
                      fit: BoxFit
                          .cover, // Ensures the image covers the space without changing aspect ratio
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(), // Adds flexible space between image and button
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: count == 0
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            count++;
                            widget.onCountChange(1, widget.price);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .onPrimaryFixedVariant, // Background color of the button
                          foregroundColor: Colors.white, // Text color
                        ),
                        child: const Text("Add +"),
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
                                  widget.onCountChange(-1, widget.price);
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
                                widget.onCountChange(1, widget.price);
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
