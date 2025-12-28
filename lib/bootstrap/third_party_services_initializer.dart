import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';
import '../presentation/sharedprefrences/preferences/prefs_controller.dart';

class ThirdPartyServicesInitializer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initFirebase();
    await _initPrefs();
    await _initHive();
    _initSystemUI();
  }

  static Future<void> _initPrefs() async {
    try {
      await PrefsController.instance.init();
      _logSuccess('SharedPreferences');
    } catch (e, s) {
      _logFailure('SharedPreferences', e, s);
    }
  }

  static Future<void> _initHive() async {
    try {
      await Hive.initFlutter();
      await Hive.openBox('user_settings');
      _logSuccess('Hive');
    } catch (e, s) {
      _logFailure('Hive', e, s);
    }
  }

  static Future<void> _initFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _logSuccess('Firebase');
    } catch (e, s) {
      _logFailure('Firebase', e, s);
    }
  }

  static void _initSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  static void _logSuccess(String service) {
    debugPrint('✅ $service connected');
  }

  static void _logFailure(String service, Object error, StackTrace stackTrace) {
    debugPrint('❌ $service connection failed');
    debugPrint('Error: $error');
    debugPrint('StackTrace: $stackTrace');
  }
}
