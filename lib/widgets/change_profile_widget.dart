import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileDialog extends StatefulWidget {
  final String initialUsername;
  final String initialAddress;
  final String initialPhoneNumber;
  final String initialInfo;
  final String? initialProfileImageBase64;
  final Function(String, String, String, String, String?) onSave;

  const ChangeProfileDialog({
    super.key,
    required this.initialUsername,
    required this.initialAddress,
    required this.initialPhoneNumber,
    required this.initialInfo,
    required this.initialProfileImageBase64,
    required this.onSave,
  });

  @override
  _ChangeProfileDialogState createState() => _ChangeProfileDialogState();
}

class _ChangeProfileDialogState extends State<ChangeProfileDialog> {
  late TextEditingController _usernameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _infoController;
  String? _selectedProfileImageBase64;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _addressController = TextEditingController(text: widget.initialAddress);
    _phoneNumberController =
        TextEditingController(text: widget.initialPhoneNumber);
    _infoController = TextEditingController(text: widget.initialInfo);
    _selectedProfileImageBase64 = widget.initialProfileImageBase64;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = File(pickedFile.path).readAsBytesSync();
      setState(() {
        _selectedProfileImageBase64 = base64Encode(bytes);
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedProfileImageBase64 != null
                    ? MemoryImage(base64Decode(_selectedProfileImageBase64!))
                    : const AssetImage("assets/images/product.jpg")
                        as ImageProvider,
                child: _selectedProfileImageBase64 == null
                    ? const Icon(Icons.camera_alt)
                    : null,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration:
                  const InputDecoration(labelText: 'Enter new username'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Enter new address'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _phoneNumberController,
              decoration:
                  const InputDecoration(labelText: 'Enter new phone number'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _infoController,
              decoration: const InputDecoration(labelText: 'Enter new info'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
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
            widget.onSave(
              _usernameController.text,
              _addressController.text,
              _phoneNumberController.text,
              _infoController.text,
              _selectedProfileImageBase64, // Pass the selected or updated image
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
