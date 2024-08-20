import 'package:waiterless/cacheManager/cacheManager.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}

class Cafebranchdata implements JsonSerializable {
  final int id;
  final String name;
  final String description;
  final String? imageBase64;

  Cafebranchdata({
    required this.id,
    required this.name,
    required this.description,
    this.imageBase64,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageBase64': imageBase64,
    };
  }

  factory Cafebranchdata.fromJson(Map<String, dynamic> json) {
    return Cafebranchdata(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageBase64: json['imageBase64'],
    );
  }
  List<Cafebranchdata> parseJsonToBranches(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);

    List<Cafebranchdata> branches = jsonList
        .map((json) => Cafebranchdata.fromJson(json as Map<String, dynamic>))
        .toList();

    return branches;
  }

  static Future<void> writeBranchesToCache(
      List<Cafebranchdata> branches) async {
    List<Map<String, dynamic>> jsonList =
        branches.map((branch) => branch.toJson()).toList();
    await CacheManager().saveData("cofebranches", jsonList);
  }

  Future<List<Cafebranchdata>?> getBranchesFromCache() async {
    var jsonList = await CacheManager().getData("cofebranches");

    if (jsonList != null && jsonList is List) {
      return jsonList
          .map((json) => Cafebranchdata.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return null;
  }

  Future<Cafebranchdata?> getBranch(int id) async {
    var list = await getBranchesFromCache();
    return list?.firstWhere((branch) => branch.id == id);
  }

  static Future<String> imageToBase64(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }

  static Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }
}
