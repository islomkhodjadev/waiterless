import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();

  factory CacheManager() {
    return _instance;
  }

  CacheManager._internal();

  Future<void> saveData<T>(String key, T data) async {
    var box = await Hive.openBox('cacheBox');
    print(T);
    if (data is dynamic && data.toJson != null) {
      print("helloo -----------------------");
      box.put(key, data.toJson());
    } else {
      throw ArgumentError(
          "Object of type ${data.runtimeType} does not implement toJson()");
    }
  }

  Future<T?> getData<T>(String key) async {
    var box = await Hive.openBox('cacheBox');
    var json = box.get(key);
    return json;
  }

  Future<void> removeData(String key) async {
    var box = await Hive.openBox('cacheBox');
    box.delete(key);
  }

  Future<void> clearAllData() async {
    var box = await Hive.openBox('cacheBox');
    box.clear();
  }
}
