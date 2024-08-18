import "package:flutter/material.dart";
import "package:waiterless/screens/cafe_screen.dart";

class Cafebranchcart extends StatelessWidget {
  const Cafebranchcart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение кафе
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CafeScreen()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.asset(
                "assets/images/cafeimage.jpg",
                width: double.infinity,
                height: 200, // Увеличенный размер изображения
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Название кафе
                Text(
                  "this is cafe name",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8.0),
                // Описание кафе с возможностью нажатия
                GestureDetector(
                  onTap: () {
                    _showFullDescription(context);
                  },
                  child: Text(
                    "this is cafe's description",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFullDescription(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Full Description"),
          content: const Text(
            "This is the full description of the cafe. "
            "It includes all the details about the cafe, such as its location, "
            "specialties, history, and much more.",
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
