import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final ImageProvider? image;
  final VoidCallback onEditPressed;

  const ProfilePicture({
    super.key,
    required this.onEditPressed,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipOval(
            child: image != null
                ? Image(
                    image: image!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/product.jpg", // Default image
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: onEditPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
