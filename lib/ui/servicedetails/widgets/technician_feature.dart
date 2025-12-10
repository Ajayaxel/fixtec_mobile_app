import 'package:fixteck/const/themes/app_themes.dart';
import 'package:flutter/material.dart';

class TechnicianFeature extends StatelessWidget {
  final String text;

  const TechnicianFeature({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.verified_user_outlined, size: 20, color: AppThemes.bgColor),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
          ),
        ),
      ],
    );
  }
}
