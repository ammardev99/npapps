import 'package:flutter/material.dart';
import 'package:npapp/presentation/siraat/menu.dart';
import 'package:npapp/presentation/siraat/parah_list.dart';

class Siraat extends StatefulWidget {
  const Siraat({super.key});

  @override
  State<Siraat> createState() => _SiraatState();
}

class _SiraatState extends State<Siraat> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // DashboardScreen(),
    ParahListScreen(),
    const MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          // set active color to blue
          selectedItemColor: Colors.green,

          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          type: BottomNavigationBarType.fixed,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: "Parah",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          ],
        ),
      ),
    );
  }
}
