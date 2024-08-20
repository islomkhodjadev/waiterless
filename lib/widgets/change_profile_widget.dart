import 'package:flutter/material.dart';

class ChangeProfileDialog extends StatefulWidget {
  final String initialUsername;
  final String initialAddress;
  final String initialPhoneNumber;
  final String initialInfo;
  final Function(String, String, String, String) onSave;

  const ChangeProfileDialog({
    super.key,
    required this.initialUsername,
    required this.initialAddress,
    required this.initialPhoneNumber,
    required this.initialInfo,
    required this.onSave,
  });

  @override
  _ChangeProfileDialogState createState() => _ChangeProfileDialogState();
}

class _ChangeProfileDialogState extends State<ChangeProfileDialog> {
  late TextEditingController _usernameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _infoController;
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _addressController = TextEditingController(text: widget.initialAddress);
    _emailController = TextEditingController(text: widget.initialPhoneNumber);
    _infoController = TextEditingController(text: widget.initialInfo);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration:
                  const InputDecoration(labelText: 'Enter new username'),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Enter new address'),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Enter new email'),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _infoController,
              decoration: const InputDecoration(labelText: 'Enter new info'),
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(_usernameController.text, _addressController.text,
                _emailController.text, _infoController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final VoidCallback onEditPressed;

  const ProfilePicture({super.key, required this.onEditPressed});

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
            child: Image.asset(
              "assets/images/product.jpg", // Update this with your image path
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
