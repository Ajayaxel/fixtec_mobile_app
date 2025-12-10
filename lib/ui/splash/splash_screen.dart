import 'package:fixteck/const/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fixteck/core/storage/storage_service.dart';
import 'package:fixteck/ui/onbording/onbording_page.dart';
import 'package:fixteck/ui/login/login_page.dart';
import 'package:fixteck/ui/home/home_pagefun.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait a bit for smooth transition
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final hasToken = await StorageService.hasToken();
    final onboardingCompleted = await StorageService.isOnboardingCompleted();

    if (!mounted) return;

    if (!onboardingCompleted) {
      // First time - show onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnbordingPage()),
      );
    } else if (hasToken) {
      // User is logged in - go to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // No token - show login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppThemes.bgColor;
    final isDarkBackground = backgroundColor == AppThemes.bgColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: CupertinoActivityIndicator(
          radius: 15,
          color: isDarkBackground ? Colors.white : const Color(0xff00343D),
        ),
      ),
    );
  }
}
