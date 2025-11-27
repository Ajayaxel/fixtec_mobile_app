import 'dart:async';
import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/ui/home/home_pagefun.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../const/themes/app_themes.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({super.key, this.phoneNumber = '+911234567890'});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _timerSeconds = 19;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timerSeconds = 19;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String _formatTimer() {
    final minutes = (_timerSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timerSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/login/otptop.png',
              fit: BoxFit.cover,
              height: 350,
              width: 450,
            ),
          ),
          // White overlay container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
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
                    const SizedBox(height: 24),
                    // Instruction text - centered
                    Center(
                      child: Text(
                        'Enter OTP sent to ${widget.phoneNumber}',
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                   
                    const SizedBox(height: 32),
                    // OTP input fields
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 50, right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: TextField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: GoogleFonts.manrope(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.0,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.zero,
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
                                    color: AppThemes.bgBtnColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) => _onOtpChanged(index, value),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 200),
                    // Resend OTP timer
                    Center(
                      child: SizedBox(
                        child: _canResend
                            ? GestureDetector(
                                onTap: () {
                                  _startTimer();
                                },
                                child: Text(
                                  'Resend OTP',
                                   style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: AppThemes.bgBtnColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Resent OTP in '),
                                    TextSpan(
                                      text: _formatTimer(),
                                      style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Confirm button
                    FixtecBtn(
                      onPressed: () {
                        final otp = _otpControllers.map((c) => c.text).join();
                        if (otp.length == 4) {
                          // Navigate to home page after successful OTP verification
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                            (route) => false, // Remove all previous routes
                          );
                        } else {
                          // Show error if OTP is incomplete
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter complete OTP',
                                style: GoogleFonts.manrope(),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      bgColor: AppThemes.bgBtnColor,
                      textColor: AppThemes.textBtnColor,
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
