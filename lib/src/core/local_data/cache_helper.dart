import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  final FlutterSecureStorage secureStorge = const FlutterSecureStorage();

  // late final FlutterSecureStorage secureStorge;
  // CacheHelper() {
  //   init();
  // }

  // init() async {
  //   secureStorge = di.sl<FlutterSecureStorage>();
  // }

  Future<String> readValue(String key) async {
    String value = await secureStorge.read(key: key) ?? '';
    return value;
  }

  Future<bool> isLogedIn() async {
    String value = await secureStorge.read(key: 'user_logged_in') ?? '';
    if (value == '' || value == 'false') {
      return false;
    }
    return true;
  }

  Future<bool> isFirstTime() async {
    String value = await secureStorge.read(key: 'first_time') ?? '';
    if (value == '' || value == 'true') {
      return true;
    }
    return false;
  }

  Future<dynamic> readObject(String key) async {
    String value = await secureStorge.read(key: key) ?? '';
    print('hello login error ${value}');
    return jsonDecode(json.decode(value));
  }

  Future<String> getLocaleLang() async {
    String value = await secureStorge.read(key: 'device_locale') ?? 'en';
    return value;
  }

  Future<void> disableIntroScreen() async {
    await secureStorge.write(key: 'first_time', value: 'true');
  }

  Future<void> writeUserLogin() async {
    await secureStorge.write(key: 'user_logged_in', value: 'true');
  }

  Future<void> writeObject(String key, String value) async {
    String mapValue = json.encode(value);
    await secureStorge.write(key: key, value: mapValue);
  }

  Future<void> write(String key, String value) async {
    await secureStorge.write(key: key, value: value);
  }

  Future<void> chnageLocaleDevice(String value) async {
    await secureStorge.write(key: 'device_locale', value: value);
  }

  Future<void> logout() async {
    await secureStorge.delete(key: 'user_logged_in');
    await secureStorge.delete(key: 'user_data');
    await secureStorge.delete(key: 'user_token');
  }
}
