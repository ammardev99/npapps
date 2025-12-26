import 'package:flutter/material.dart';

class ValuesPageState extends StatefulWidget {
  const ValuesPageState({super.key});

  @override
  State<ValuesPageState> createState() => _ValuesPageStateState();
}

class _ValuesPageStateState extends State<ValuesPageState> {
  int age = 18;
  RangeValues priceRange = const RangeValues(100, 500);
  bool isDarkTheme = false;
  bool rememberMe = false;
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Values (State Only)')),
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
                  onPressed: () => setState(() => age--),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => age++),
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
            onChanged: (v) {
              setState(() => priceRange = v);
            },
          ),

          /// THEME SWITCH
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: isDarkTheme,
            onChanged: (v) => setState(() => isDarkTheme = v),
          ),

          /// REMEMBER ME
          CheckboxListTile(
            title: const Text('Remember Me'),
            value: rememberMe,
            onChanged: (v) => setState(() => rememberMe = v!),
          ),

          /// GENDER
          const SizedBox(height: 16),
          const Text('Gender'),
          DropdownButton<String>(
            value: gender,
            items: ['Male', 'Female', 'Other']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => gender = v!),
          ),
        ],
      ),
    );
  }
}
