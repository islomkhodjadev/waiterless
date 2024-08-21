import 'dart:convert'; // For base64 encoding/decoding
import 'dart:typed_data'; // For working with image bytes
import 'dart:io'; // For file handling

import 'package:waiterless/cacheManager/cacheManager.dart';

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}

class User implements JsonSerializable {
  final int id;
  final String username;
  final String phoneNumber;
  final String info;
  final String address;
  final String? profileImageBase64; // Add image as a Base64 string

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.info,
    required this.address,
    this.profileImageBase64, // Optional image
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phoneNumber': phoneNumber,
      'info': info,
      'address': address,
      'profileImageBase64': profileImageBase64, // Include the image in JSON
    };
  }

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      info: json['info'],
      address: json['address'],
      profileImageBase64:
          json['profileImageBase64'], // Retrieve image from JSON
    );
  }

  // Static method to write a User to cache
  static Future<void> writeToCache(User user) async {
    await CacheManager().saveData<JsonSerializable>("user", user);
  }

  User copyWith({
    int? id,
    String? username,
    String? phoneNumber,
    String? info,
    String? address,
    String? profileImageBase64,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      info: info ?? this.info,
      address: address ?? this.address,
      profileImageBase64: profileImageBase64 ?? this.profileImageBase64,
    );
  }

  // Static method to read a User from cache
  static Future<User?> readFromCache() async {
    var json = await CacheManager().getData("user");
    print("------------------");
    print(json);
    print("-------------------------");
    if (json != null) {
      return User.fromJson(json);
    }
    return null;
  }

  // Helper method to convert image file to Base64 string
  static Future<String> imageToBase64(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }

  // Helper method to convert Base64 string to image bytes
  static Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }
}
