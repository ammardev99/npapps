import 'dart:async';
import 'package:flutter/material.dart';
import 'package:npapp/presentation/sharedprefrences/preferences/prefs_controller.dart';

class ValuesPagePrefs extends StatefulWidget {
  const ValuesPagePrefs({super.key});

  @override
  State<ValuesPagePrefs> createState() => _ValuesPagePrefsState();
}

class _ValuesPagePrefsState extends State<ValuesPagePrefs> {
  final prefs = PrefsController.instance;

  int age = 18;
  RangeValues priceRange = const RangeValues(100, 500);
  bool isDarkTheme = false;
  bool rememberMe = false;
  String gender = 'Male';

  Timer? _debounceSlider;

  @override
  void initState() {
    super.initState();
    _loadFromPrefs();
  }

  void _loadFromPrefs() {
    if (!prefs.isReady) return;

    setState(() {
      age = prefs.getAge();
      priceRange = RangeValues(
        prefs.getPriceStart(),
        prefs.getPriceEnd(),
      );
      isDarkTheme = prefs.getTheme();
      rememberMe = prefs.getRemember();
      gender = prefs.getGender();
    });
  }

  void _save() {
    prefs.save(
      age: age,
      priceStart: priceRange.start,
      priceEnd: priceRange.end,
      theme: isDarkTheme,
      remember: rememberMe,
      gender: gender,
    );
  }

  /// Debounce for slider to prevent too many writes
  void _onPriceChanged(RangeValues values) {
    setState(() => priceRange = values);

    _debounceSlider?.cancel();
    _debounceSlider = Timer(const Duration(milliseconds: 200), () {
      _save();
    });
  }

  @override
  void dispose() {
    _debounceSlider?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Values (SharedPreferences)')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
      
            /// AGE
            ListTile(
              title: Text('Age: $age'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() => age--);
                      _save();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() => age++);
                      _save();
                    },
                  ),
                ],
              ),
            ),
      
            /// PRICE RANGE
            const SizedBox(height: 16),
            Text('Price Range: ${priceRange.start.round()} - ${priceRange.end.round()}'),
            RangeSlider(
              min: 0,
              max: 1000,
              values: priceRange,
              onChanged: _onPriceChanged,
            ),
      
            /// THEME
            SwitchListTile(
              title: const Text('Dark Theme'),
              value: isDarkTheme,
              onChanged: (v) {
                setState(() => isDarkTheme = v);
                _save();
              },
            ),
      
            /// REMEMBER ME
            CheckboxListTile(
              title: const Text('Remember Me'),
              value: rememberMe,
              onChanged: (v) {
                setState(() => rememberMe = v!);
                _save();
              },
            ),
      
            /// GENDER
            const SizedBox(height: 16),
            const Text('Gender'),
            DropdownButton<String>(
              value: gender,
              isExpanded: true,
              items: ['Male', 'Female', 'Other']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                setState(() => gender = v!);
                _save();
              },
            ),
          ],
        ),
      ),
    );
  }
}
