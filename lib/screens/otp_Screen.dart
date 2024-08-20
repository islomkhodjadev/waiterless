import 'package:flutter/material.dart';
import 'package:waiterless/widgets/appbar.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  OTPScreen({required this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "OTP verification"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text("Enter the OTP sent to ${widget.phoneNumber}"),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              style: TextStyle(
                color: Colors.black, // Set the color of the input text here
                fontSize: 16.0, // You can also adjust the font size
              ),
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (Route<dynamic> route) => false);
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
