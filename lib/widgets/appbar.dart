import 'package:flutter/material.dart';
import 'package:waiterless/widgets/listeningDialog.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.mic,
            color: Colors.white,
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
