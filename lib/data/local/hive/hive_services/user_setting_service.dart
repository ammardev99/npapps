import 'package:hive/hive.dart';

import '../user_setting_keys.dart';

class UserSettingService {
  static final Box _box = Hive.box('user_settings');

  // USER NAME
  static Future<void> setUserName(String name) async {
    await _box.put(UserSettingKeys.userName, name);
  }

  static String getUserName() {
    return _box.get(UserSettingKeys.userName, defaultValue: '');
  }

  // AGE
  static Future<void> setAge(int age) async {
    await _box.put(UserSettingKeys.age, age);
  }

  static int getAge() {
    return _box.get(UserSettingKeys.age, defaultValue: 0);
  }

  // FONT SIZE
  static Future<void> setFontSize(double size) async {
    await _box.put(UserSettingKeys.fontSize, size);
  }

  static double getFontSize() {
    return _box.get(UserSettingKeys.fontSize, defaultValue: 12.0);
  }

  // THEME
  static Future<void> setTheme(bool isDark) async {
    await _box.put(UserSettingKeys.isDarkTheme, isDark);
  }

  static bool isDarkTheme() {
    return _box.get(UserSettingKeys.isDarkTheme, defaultValue: false);
  }

  // GENDER
  static Future<void> setGender(String gender) async {
    await _box.put(UserSettingKeys.gender, gender);
  }

  static String getGender() {
    return _box.get(UserSettingKeys.gender, defaultValue: 'other');
  }
}
