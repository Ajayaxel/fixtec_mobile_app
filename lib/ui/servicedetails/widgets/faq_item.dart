import 'package:flutter/material.dart';

class FAQItem extends StatelessWidget {
  final String text;

  const FAQItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
          SizedBox(width: 16),
          Icon(Icons.add, size: 24, color: Colors.black54),
        ],
      ),
    );
  }
}
