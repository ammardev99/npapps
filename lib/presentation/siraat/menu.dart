import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:npapp/controllers/auth_controller.dart';
import 'package:npapp/presentation/control_panel.dart';
import 'package:npapp/presentation/language_selection_screen.dart';
import 'package:npapp/presentation/sharedprefrences/values.dart';
import 'package:npapp/presentation/sharedprefrences/values_page_prefs.dart';

import '../hive_settings_page.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final User? user = _authController.currentUser;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        /// USER INFO CARD
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const CircleAvatar(radius: 24, child: Icon(Icons.person)),
            title: Text(
              user?.email ?? "Guest User",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              user != null ? "UID: ${user.uid}" : "Not logged in",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        const SizedBox(height: 24),

        /// SECTION: SETTINGS
        const Text("Menu", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        _menuTile(
          icon: Icons.dashboard_customize,
          title: "Control Panel",
          onTap: () {
            // Navigate to ControlPanel() screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ControlPanel()),
            );
          },
        ),
        _menuTile(
          icon: Icons.dashboard_customize,
          title: "Language",
          onTap: () {
            // Navigate to ControlPanel() screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LanguageSelectionScreen(),
              ),
            );
          },
        ),
        _menuTile(
          icon: Icons.dashboard_customize,
          title: "Values",
          onTap: () {
            // Navigate to ControlPanel() screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ValuesPageState()),
            );
          },
        ),
        _menuTile(
          icon: Icons.dashboard_customize,
          title: "Stored Values",
          onTap: () {
            // Navigate to ControlPanel() screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ValuesPagePrefs()),
            );
          },
        ),
        _menuTile(
          icon: Icons.dashboard_customize,
          title: "Local Hive Setting",
          onTap: () {
            // Navigate to ControlPanel() screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HiveSettingsPage()),
            );
          },
        ),
        /// LOGOUT
        Card(
          color: Colors.red.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () async {
              await _authController.logout(context);
            },
          ),
        ),
      ],
    );
  }

  /// REUSABLE MENU TILE
  Widget _menuTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
