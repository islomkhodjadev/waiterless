import 'package:flutter/material.dart';
import 'package:waiterless/models/userData.dart';
import 'package:waiterless/widgets/appbar.dart';
import 'package:waiterless/widgets/change_profile_widget.dart';
import 'dart:io';

import 'package:waiterless/widgets/profilePicture.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  ProfileScreen({super.key, required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserFromCache();
  }

  // Load user data from the cache
  Future<void> _loadUserFromCache() async {
    User? cachedUser = await User.readFromCache();
    if (cachedUser != null) {
      setState(() {
        _user = cachedUser;
        _isLoading = false;
      });
    } else {
      // If no user is found in the cache, set the default values
      setState(() {
        _user = User(
          id: 1,
          username: widget.username,
          phoneNumber: "+998993691864",
          info: "Welcome back!",
          address: "123 Main St, Springfield",
          profileImageBase64: null, // Default to no image
        );
        _isLoading = false;
      });
    }
  }

  // Handle the save operation in the edit profile dialog
  void _openEditProfileDialog() {
    if (_user == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) => ChangeProfileDialog(
        initialUsername: _user!.username,
        initialAddress: _user!.address,
        initialPhoneNumber: _user!.phoneNumber,
        initialInfo: _user!.info,
        initialProfileImageBase64: _user!.profileImageBase64,
        onSave: (newUsername, newAddress, newPhoneNumber, newInfo,
            newProfileImageBase64) async {
          // Create a new User object with updated values using copyWith
          User updatedUser = _user!.copyWith(
            username: newUsername,
            address: newAddress,
            phoneNumber: newPhoneNumber,
            info: newInfo,
            profileImageBase64: newProfileImageBase64,
          );

          // Save the updated user to cache
          await User.writeToCache(updatedUser);

          // Update the UI with the new user data
          setState(() {
            _user = updatedUser;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Profile"),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24.0),

                  // Profile Picture Section
                  Center(
                    child: ProfilePicture(
                      image: _user?.profileImageBase64 != null
                          ? MemoryImage(
                              User.base64ToImage(_user!.profileImageBase64!))
                          : const AssetImage(
                              "assets/images/product.jpg"), // Use a default image if base64 is null
                      onEditPressed: _openEditProfileDialog,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Username and Info
                  Center(
                    child: Column(
                      children: [
                        Text(
                          _user?.username ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          _user?.info ?? '',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          _buildUserInfoRow(Icons.location_on,
                              _user?.address ?? 'No address available'),
                          const SizedBox(height: 8.0),
                          _buildUserInfoRow(Icons.phone,
                              _user?.phoneNumber ?? 'No phone available'),
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
                            print(_user?.username ?? '');
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
