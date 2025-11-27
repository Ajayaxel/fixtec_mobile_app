import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/const/themes/app_themes.dart';
import 'package:fixteck/ui/login/login_page.dart';
import 'package:flutter/material.dart';

class OnbordingPage extends StatelessWidget {
  const OnbordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onbording/Start.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Dark teal-blue overlay
          decoration: BoxDecoration(
            color: Color(0xFF1A4A5C).withOpacity(0),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Spacer to push content to lower-left
                Spacer(),
                // Content section aligned to lower-left
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Headline
                      Text(
                        "Home services at your doorstep",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Separator/Progress bar
                      Container(
                        width: 60,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Body text
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and Ipsum is simply dummy",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24),
                      // Pagination indicators
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 24,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 24,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      // Button at the bottom
                      FixtecBtn(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        bgColor: AppThemes.textBtnColor,
                        textColor: AppThemes.bgColor,
                        child: const Text("Let's start"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
