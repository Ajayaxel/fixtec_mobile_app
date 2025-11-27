import 'package:fixteck/ui/bottom_nav/bottom_nav_bar.dart';
import 'package:fixteck/ui/home/home_page.dart';
import 'package:fixteck/ui/bookings/bookings_page.dart';
import 'package:fixteck/ui/account/account_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const HomeContent();
      case 1:
        return const BookingsPage();
      case 2:
        return const AccountPage();
      default:
        return const HomePage();
    }
  }
}

