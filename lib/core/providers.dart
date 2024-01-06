import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeko_pointage/core/constants/application_constants.dart';
import 'package:yeko_pointage/core/constants/shared_prefs.dart';

part 'providers.g.dart';

/// Utility class for managing shared preferences in Flutter applications.
///
/// Provides methods for storing and retrieving various data types,
/// as well as removing preferences.
class PreferenceUtils {
  static late final SharedPreferences _prefsInstance;

  /// Initializes the SharedPreferences instance.
  ///
  /// Should be called early in the app's lifecycle.
  static Future<void> init() async {
    _prefsInstance = await _initInstance();
  }

  static Future<SharedPreferences> _initInstance() async {
    return SharedPreferences.getInstance();
  }

  /// Retrieves a string preference.
  ///
  /// Returns the stored value or the provided default value if not found.
  static String getString(String key, [String defValue = '']) {
    return _prefsInstance.getString(key) ?? defValue;
  }

  /// Sets a string preference.
  ///
  /// Returns a Future indicating success or failure.
  static Future<bool> setString(String key, String value) async {
    return _prefsInstance.setString(key, value);
  }

  /// Retrieves an integer preference.
  ///
  /// Returns the stored value or the provided default value if not found.
  static int getInt(String key, [int defValue = 0]) {
    return _prefsInstance.getInt(key) ?? defValue;
  }

  /// Sets an integer preference.
  ///
  /// Returns a Future indicating success or failure.
  static Future<bool> setInt(String key, int value) async {
    return _prefsInstance.setInt(key, value);
  }

  /// Retrieves a boolean preference.
  ///
  /// Returns the stored value or the provided default value if not found.
  static bool getBool(String key, {bool defValue = false}) {
    return _prefsInstance.getBool(key) ?? defValue;
  }

  /// Sets a boolean preference.
  ///
  /// Returns a Future indicating success or failure.
  static Future<bool> setBool(String key, {required bool value}) async {
    return _prefsInstance.setBool(key, value);
  }

  /// Retrieves a double preference.
  ///
  /// Returns the stored value or the provided default value if not found.
  static double getDouble(String key, [double defValue = 0.0]) {
    return _prefsInstance.getDouble(key) ?? defValue;
  }

  /// Sets a double preference.
  ///
  /// Returns a Future indicating success or failure.
  static Future<bool> setDouble(String key, double value) async {
    return _prefsInstance.setDouble(key, value);
  }

  /// Removes specific keys from shared preferences.
  ///
  /// If no keys are provided, clears all preferences.
  /// Returns a Future indicating success or failure.
  static Future<bool> removeKeys(List<String> keys) async {
    if (keys.isEmpty) {
      return _prefsInstance.clear(); // If no keys provided, clear all
    } else {
      for (final key in keys) {
        await _prefsInstance.remove(key);
      }
      return true; // Assuming all removals were successful
    }
  }
}

// Dio instance used to sign in
@riverpod
Dio dioInstanceAuth(DioInstanceAuthRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
    ),
  );

  // interceptors
  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       // Do something before request is sent
  //       return handler.next(options); //continue
  //     },
  //     onResponse: (response, handler) {
  //       // Do something with response data
  //       return handler.next(response); // continue
  //     },
  //     onError: (e, handler) {
  //       // remove all keys from shared preferences if token is expired
  //       if (e.response?.statusCode == 401) {
  //         PreferenceUtils.removeKeys([]);
  //       }

  //       return handler.next(e); //continue
  //     },
  //   ),
  // );

  return dio;
}

// Dio instance already authenticated
@riverpod
Dio dioInstance(DioInstanceRef ref) {
  final dio = Dio();

  // set options
  dio.options.baseUrl = AppConstants.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  // headers with token. Remember that token is saved in shared preferences
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer ${PreferenceUtils.getString(SharedPrefsConstants.token)}',
  };

  return dio;
}
