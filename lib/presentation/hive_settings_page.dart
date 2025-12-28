import 'package:flutter/material.dart';
import '../data/local/hive/hive_services/user_setting_service.dart';

class HiveSettingsPage extends StatefulWidget {
  const HiveSettingsPage({super.key});

  @override
  State<HiveSettingsPage> createState() => _HiveSettingsPageState();
}

class _HiveSettingsPageState extends State<HiveSettingsPage> {
  final TextEditingController nameController = TextEditingController(
    text: UserSettingService.getUserName(),
  );

  bool isDark = UserSettingService.isDarkTheme();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('User Settings')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'User Name'),
                onChanged: (value) {
                  UserSettingService.setUserName(value);
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Dark Theme'),
                value: isDark,
                onChanged: (value) {
                  setState(() => isDark = value);
                  UserSettingService.setTheme(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Directory dir = await getApplicationDocumentsDirectory();
// int size = await calculateDirectorySize(dir);
