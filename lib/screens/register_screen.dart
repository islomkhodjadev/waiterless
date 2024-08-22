import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add image picker dependency
import 'package:waiterless/models/userData.dart';
import 'package:waiterless/screens/otp_Screen.dart';
import 'package:waiterless/widgets/appbar.dart';
import 'dart:io'; // To work with File class

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  File? _selectedImage; // Variable to store the selected image

  @override
  void dispose() {
    _usernameController.dispose(); // Dispose the username controller
    _phoneController.dispose();
    _addressController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Save the selected image file
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Enter information"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : AssetImage('assets/images/cafeimage.jpg'),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
            ),
            SizedBox(height: 20),
            TextField(
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _infoController,
              decoration: InputDecoration(
                labelText: 'Additional Info',
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Collect all input data
                final String phoneNumber = _phoneController.text;
                final String address = _addressController.text;
                final String additionalInfo = _infoController.text;
                final String username = _usernameController.text;
                // Convert the selected image to base64 (if an image is selected)
                String? base64Image;
                if (_selectedImage != null) {
                  final bytes = File(_selectedImage!.path).readAsBytesSync();
                  base64Image = base64Encode(bytes);
                }

                // Create a data model or map to pass the collected info
                final userInfo = {
                  "username": username,
                  "phoneNumber": phoneNumber,
                  "address": address,
                  "additionalInfo": additionalInfo,
                  "base64Image":
                      base64Image, // Will be null if no image is selected
                };
                User user = User(
                    id: 1,
                    address: userInfo["address"] as String,
                    username: userInfo["username"] as String,
                    info: userInfo["additionalInfo"] as String,
                    profileImageBase64: userInfo["base64Image"],
                    phoneNumber: userInfo["phoneNumber"] as String);

                User.writeToCache(user);
                // Navigate to the next screen (e.g., OTPScreen) and pass the collected data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPScreen(
                      phoneNumber:
                          phoneNumber, // Example data passed to OTP screen
                      // Pass the entire userInfo map
                    ),
                  ),
                );
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
