import 'dart:async';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/changepassword/change_password.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  bool _isResendAvailable = false;
  int _resendTimer = 30;
  late Timer _timer;
  int _resendAttempts = 0; // Count the number of resends
  bool _isCooldown = false; // Check if cooldown period is active
  int _cooldownTimer = 30 * 60; // 30 minutes cooldown in seconds

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _isResendAvailable = false;
      _resendTimer = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer == 0) {
        setState(() {
          _isResendAvailable = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _resendTimer--;
        });
      }
    });
  }

  void _startCooldownTimer() {
    setState(() {
      _isCooldown = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_cooldownTimer == 0) {
        setState(() {
          _isCooldown = false;
          _resendAttempts = 0; // Reset resend attempts
        });
        timer.cancel();
      } else {
        setState(() {
          _cooldownTimer--;
        });
      }
    });
  }

  void _resendCode() {
    if (_isCooldown) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please wait for the cooldown period.')),
      );
      return;
    }

    if (_resendAttempts < 4) {
      setState(() {
        _resendAttempts++;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP code sent to your email.')),
      );
      _startResendTimer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Maximum attempts reached. Please wait 30 minutes.')),
      );
      _startCooldownTimer();
    }
  }

  void _verifyOtp() {
    String enteredOtp =
        _otpControllers.map((controller) => controller.text).join();

    if (enteredOtp == "1234") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePassword(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(StaticData.mybackground),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.15),

            // Logo with Fade-in and Scale Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: value,
                    child: Container(
                      height: height * 0.25,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(StaticData.myLogo),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // "Enter Verification Code" Text with Slide Animation
            TweenAnimationBuilder(
              tween: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: Container(
                    width: width * 0.85,
                    child: Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.01),

            // Description Text with Fade Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.82,
                    child: Text(
                      "A 4-digit code has been sent to ${widget.email}",
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // OTP Input Boxes with Individual Slide Animations

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  height: height * 0.06,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    maxLength: 1,
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: height * 0.03),

            // "Resend Code" Button with Fade-in Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 800),
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: _verifyOtp,
                        child: Text(
                          "Verify Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: height * 0.03),

            // "Resend Code" Button with Fade-in Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 800),
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.7,
                    child: Center(
                      child: TextButton(
                        onPressed: _isResendAvailable ? _resendCode : null,
                        child: Text(
                          _isResendAvailable
                              ? (_isCooldown
                                  ? "Cooldown: ${_cooldownTimer ~/ 60} mins"
                                  : "Resend Code")
                              : "Resend Code in $_resendTimer seconds",
                          style: TextStyle(
                            color:
                                _isResendAvailable ? Colors.blue : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
