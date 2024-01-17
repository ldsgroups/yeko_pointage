import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

// Supabase
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

@riverpod
GoTrueClient supabaseAuth(SupabaseAuthRef ref) {
  final client = ref.watch(supabaseClientProvider);

  return client.auth;
}

@riverpod
SupabaseStorageClient supabaseStorage(SupabaseStorageRef ref) {
  final client = ref.watch(supabaseClientProvider);

  return client.storage;
}
