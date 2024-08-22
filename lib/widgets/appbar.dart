import 'package:flutter/material.dart';
import 'package:waiterless/widgets/listeningDialog.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
            color: const Color.fromARGB(
                255, 0, 0, 0)), // Specify the color directly here
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.mic,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () => _showListeningPopup(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _showListeningPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ListeningDialog(),
    );
  }
}
