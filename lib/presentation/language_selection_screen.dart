import 'package:flutter/material.dart';
import 'package:npapp/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(t.appTitle)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.selectLanguage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
      
              const SizedBox(height: 12),
      
              SizedBox(
                width: double.infinity,
                child: DropdownButton<Locale>(
                  value: Localizations.localeOf(context), // <-- current locale
                  onChanged: (locale) {
                    if (locale != null) {
                      MyApp.setLocale(context, locale); // updates the app locale
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: Locale('en'), child: Text('English')),
                    DropdownMenuItem(value: Locale('ur'), child: Text('اردو')),
                    DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
                  ],
                ),
              ),
      
              const SizedBox(height: 24),
      
              Text(t.menu),
              Text(t.choosetext),
              Text(t.home),
              // Text(),
              Text(t.categories),
              Text(t.settings),
              Text(t.profile),
      
              const SizedBox(height: 20),
      
              Text(t.welcomeText, textAlign: TextAlign.justify),
      
              const Spacer(),
      
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text(t.appTitle)),
                  const SizedBox(width: 10),
                  OutlinedButton(onPressed: () {}, child: Text(t.cancel)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
