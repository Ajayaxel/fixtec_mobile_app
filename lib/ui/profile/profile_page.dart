import 'package:flutter/material.dart';
import 'package:fixteck/const/fixtec_btn.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color _backgroundColor = Color(0xFFF5F6FB);
  static const Color _buttonColor = Color(0xFF003B40); // Approximated dark teal

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: Text(
          'Profile',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit profile',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildLabel(textTheme, 'Full name'),
                    const SizedBox(height: 8),
                    _buildTextField(initialValue: 'Shafi Mohammed'),
                    const SizedBox(height: 16),
                    _buildLabel(textTheme, 'Email'),
                    const SizedBox(height: 8),
                    _buildTextField(initialValue: ''),
                    const SizedBox(height: 16),
                    _buildLabel(textTheme, 'Phone number'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: _buildTextField(
                            initialValue: '+97',
                            enabled: false,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            initialValue: '1234567890',
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FixtecBtn(
                onPressed: () {},
                bgColor: _buttonColor,
                textColor: Colors.white,
                child: Text(
                  'Save information',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(TextTheme textTheme, String label) {
    return Text(
      label,
      style: textTheme.bodyMedium?.copyWith(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required String initialValue,
    bool enabled = true,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.transparent : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        textAlign: textAlign,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: enabled ? const Color(0xFFF5F6FB) : Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
