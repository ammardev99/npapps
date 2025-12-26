import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'prefs_keys.dart';

class PrefsController {
  PrefsController._();
  static final PrefsController instance = PrefsController._();

  SharedPreferences? _prefs;
  bool _isInitialized = false;

  /// Initialize ONLY ONCE
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      debugPrint('SharedPrefs: Initializing (Controller)...');
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
      debugPrint('SharedPrefs: Ready');
    } catch (e, s) {
      debugPrint('❌ SharedPrefs INIT FAILED');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  bool get isReady => _prefs != null;

  /// READS
  bool getTheme() => _prefs?.getBool(PrefKeys.theme) ?? false;
  bool getRemember() => _prefs?.getBool(PrefKeys.remember) ?? false;
  String getGender() => _prefs?.getString(PrefKeys.gender) ?? 'Male';
  int getAge() => _prefs?.getInt(PrefKeys.age) ?? 18;
  double getPriceStart() => _prefs?.getDouble(PrefKeys.priceStart) ?? 100;
  double getPriceEnd() => _prefs?.getDouble(PrefKeys.priceEnd) ?? 500;

  /// WRITES
  Future<void> save({
    required int age,
    required double priceStart,
    required double priceEnd,
    required bool theme,
    required bool remember,
    required String gender,
  }) async {
    if (_prefs == null) {
      debugPrint('⚠ Save skipped: SharedPrefs not ready');
      return;
    }

    try {
      await _prefs!.setInt(PrefKeys.age, age);
      await _prefs!.setDouble(PrefKeys.priceStart, priceStart);
      await _prefs!.setDouble(PrefKeys.priceEnd, priceEnd);
      await _prefs!.setBool(PrefKeys.theme, theme);
      await _prefs!.setBool(PrefKeys.remember, remember);
      await _prefs!.setString(PrefKeys.gender, gender);

      debugPrint(
        'SharedPrefs SAVED -> age:$age, range:$priceStart-$priceEnd, '
        'theme:$theme, remember:$remember, gender:$gender',
      );
    } catch (e, s) {
      debugPrint('❌ SharedPrefs SAVE FAILED');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }
}
