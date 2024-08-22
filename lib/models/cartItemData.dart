import 'package:waiterless/cacheManager/cacheManager.dart';

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}

class CartItemData implements JsonSerializable {
  final int productId;
  final int productCount;
  final double totalPrice;
  final String productName;
  CartItemData(
      {required this.productId,
      required this.productCount,
      required this.totalPrice,
      required this.productName});

  @override
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productCount': productCount,
      'totalPrice': totalPrice,
      'productName': productName
    };
  }

  static CartItemData fromJson(Map<String, dynamic> json) {
    return CartItemData(
        productId: json['productId'],
        productCount: json['productCount'],
        totalPrice: json['totalPrice'],
        productName: json["productName"]);
  }

  // Add a CartItem to the cache under a single key
  static Future<void> addCartItem(CartItemData item) async {
    final cacheManager = CacheManager();

    // Retrieve the existing list of cart items
    // Retrieve the existing list of cart items
    List<dynamic> cartItemListDynamic =
        await cacheManager.getData<List<dynamic>>('cartItems') ?? [];
    List<Map<String, dynamic>> cartItemList = cartItemListDynamic.map((item) {
      return Map<String, dynamic>.from(item as Map);
    }).toList();

// Now proceed with your index search
    final index = cartItemList
        .indexWhere((element) => element['productId'] == item.productId);

    // Add or update the item in the list
    if (index != -1) {
      // Update the existing item
      cartItemList[index] = item.toJson();
    } else {
      // Add the new item to the list
      cartItemList.add(item.toJson());
    }

    // Save the updated list back to the cache
    await cacheManager.saveData('cartItems', cartItemList);
  }

  // Get one CartItem by productId
  static Future<CartItemData?> getCartItem(int productId) async {
    final cacheManager = CacheManager();

    // Retrieve the list of cart items
    List<dynamic> cartItemListDynamic =
        await cacheManager.getData<List<dynamic>>('cartItems') ?? [];
    List<Map<String, dynamic>> cartItemList = cartItemListDynamic.map((item) {
      return Map<String, dynamic>.from(item as Map);
    }).toList();

    // Use firstWhere to find the item, or return null if not found
    Map<String, dynamic>? itemData = cartItemList.firstWhere(
        (element) => element['productId'] == productId,
        orElse: () => {} // Return null if no item found
        );

    // If itemData is null or empty, return null
    if (itemData == null || itemData.isEmpty) {
      return null;
    }

    // If itemData is not empty, convert it to CartItemData
    return CartItemData.fromJson(itemData);
  }

  // Get all CartItems from the cache
  static Future<List<CartItemData>> getAllCartItems() async {
    final cacheManager = CacheManager();

    // Retrieve the list of cart items
    List<dynamic> cartItemListDynamic =
        await cacheManager.getData('cartItems') ?? [];
    List<Map<String, dynamic>> cartItemList = cartItemListDynamic.map((item) {
      return Map<String, dynamic>.from(item); // Safely convert the map
    }).toList();

// Then proceed with the mapping to CartItemData
    List<CartItemData> items = cartItemList.map((data) {
      return CartItemData.fromJson(data);
    }).toList();

    return items;
  }

  static Future<void> removeCartItem(int productId) async {
    final cacheManager = CacheManager();

    List<Map<String, dynamic>> cartItemList =
        await cacheManager.getData<List<Map<String, dynamic>>>('cartItems') ??
            [];

    cartItemList.removeWhere((item) => item['productId'] == productId);

    await cacheManager.saveData('cartItems', cartItemList);
  }

  static Future<void> clearAllCartItems() async {
    final cacheManager = CacheManager();

    await cacheManager.removeData('cartItems');
  }
}
