import 'dart:ui';
import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/ui/login/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../const/themes/app_themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _agreeToTerms = false;
  String _selectedCountryCode = '+91';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          Positioned.fill(
            child: Image.asset('assets/login/Rectangle 22836 (1).png', fit: BoxFit.cover,height: 350,width: 450,),
          ),
 // Login container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // FIXTEK Title
                    Text(
                      'FIXTEK',
                      style: GoogleFonts.manrope(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Login or Sign up text
                    Text(
                      'Login or Sign up to continue',
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Mobile number input section
                    Row(
                      children: [
                        // Country code dropdown
                        Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCountryCode,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down, size: 20),
                              items: ['+91', '+1', '+44', '+86'].map((
                                String code,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(
                                    code,
                                    style: GoogleFonts.manrope(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedCountryCode = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Mobile number input
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Enter your mobile number',
                              hintStyle: GoogleFonts.manrope(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                            ),
                            style: GoogleFonts.manrope(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // OTP information text
                    Text(
                      'We will send an OTP to confirm the number',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Color(0xff6B6E8D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 140),
                    // Terms and conditions checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                          activeColor: AppThemes.bgBtnColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              children: [
                                const TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: AppThemes.bgBtnColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: AppThemes.bgBtnColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Get verification code button
                    FixtecBtn(
                      onPressed: () {
                        final phoneNumber = '$_selectedCountryCode${_phoneController.text}';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpPage(phoneNumber: phoneNumber),
                          ),
                        );
                      },
                      bgColor: AppThemes.bgBtnColor,
                      textColor: AppThemes.textBtnColor,
                      child: Text("Get verification code"),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          // Bottom center decorative image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/login/bootmcenterbg.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
