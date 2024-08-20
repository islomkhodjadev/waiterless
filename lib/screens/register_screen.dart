import 'package:flutter/material.dart';
import 'package:waiterless/screens/otp_Screen.dart';
import 'package:waiterless/widgets/appbar.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
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
              onTap: () {
                // Function to handle image selection
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/cafeimage.jpg'), // Placeholder image
                child: Icon(
                    Icons.camera_alt), // Icon to indicate to tap and upload
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.black, // Set the color of the input text here
                fontSize: 16.0, // You can also adjust the font size
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(
                color: Colors.black, // Set the color of the input text here
                fontSize: 16.0, // You can also adjust the font size
              ),
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OTPScreen(phoneNumber: _phoneController.text)),
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
