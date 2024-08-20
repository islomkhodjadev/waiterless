import 'package:flutter/material.dart';
import 'package:waiterless/widgets/appbar.dart';
import 'package:waiterless/widgets/change_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  ProfileScreen({super.key, required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  String address = "123 Main St, Springfield";
  String phoneNumber = "+998993691864";
  String info = "Welcome back!";

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  void _openEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ChangeProfileDialog(
        initialUsername: username,
        initialAddress: address,
        initialPhoneNumber: phoneNumber,
        initialInfo: info,
        onSave: (newUsername, newAddress, newPhoneNumber, newInfo) {
          setState(() {
            username = newUsername;
            address = newAddress;
            phoneNumber = newPhoneNumber;
            info = newInfo;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24.0),

            // Profile Picture Section
            Center(
              child: ProfilePicture(onEditPressed: _openEditProfileDialog),
            ),
            const SizedBox(height: 16.0),

            // Username and Info
            Center(
              child: Column(
                children: [
                  Text(
                    username,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    info,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // User Information Section
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfoRow(Icons.location_on, address),
                    const SizedBox(height: 8.0),
                    _buildUserInfoRow(Icons.email, phoneNumber),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for calling
                    },
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text("Call"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for sending a message
                    },
                    icon: const Icon(Icons.message, color: Colors.white),
                    label: const Text("Message"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }
}
