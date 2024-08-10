import "package:flutter/material.dart";

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
