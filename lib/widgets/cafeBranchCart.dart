import "package:flutter/material.dart";

class Cafebranchcart extends StatelessWidget {
  const Cafebranchcart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Image.asset(
          "assets/images/cafeimage.jpg",
          width: 100,
          fit: BoxFit.cover,
        ),
        title: const Text("this is cafe name"),
        subtitle: GestureDetector(
            onTap: () {
              _showFullDescription(context);
            },
            child: const Text("this is cafe's description")),
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
