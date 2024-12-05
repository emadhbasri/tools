import 'package:shared_preferences/shared_preferences.dart';
export 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
export 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<List<String>> getKeys() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getKeys().toList();
}

Future<void> deleteKey(String key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove(key);
}
Future<void> deleteKeySec(String key) async {
  const FlutterSecureStorage storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  await storage.delete(key: key);
}

Future<void> setBool(String key, bool value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool(key, value);
}

Future<bool?> getBool(String key, {bool? def}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.containsKey(key)) {
    return pref.getBool(key)!;
  } else {
    return null;
  }
}

Future<void> setInt(String key, int value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt(key, value);
}

Future<int?> getInt(String key, {int? def}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  if (pref.containsKey(key)) {
    return pref.getInt(key)!;
  } else {
    return def;
  }
}

Future<void> setString(String key, String value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(key, value);
}

Future<String?> getString(String key, {String? def}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.containsKey(key)) {
    return pref.getString(key)!;
  } else {
    return null;
  }
}

Future<void> setStringSec(String key, String value) async {
  const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  await storage.write(key: key, value: value);
}

Future<String?> getStringSec(String key, {String? def}) async {
  const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  return await storage.read(key: key);
}

Future<bool> setList(String key, List<String> value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setStringList(key, value);
}

Future<List<String>> getList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey(key)) {
    return prefs.getStringList(key)!;
  } else {
    return [];
  }
}
