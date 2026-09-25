import 'package:expense_app/screen/home.dart';
import 'package:expense_app/screen/profile.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        indicatorColor: Theme.of(
          context,
        ).colorScheme.primary,
        selectedIndex: _selectIndex,
        onDestinationSelected: (value) => setState(() => _selectIndex = value),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: _selectIndex == 0 ? Home() : Profile(),
    );
  }
}
