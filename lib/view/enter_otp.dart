import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/change_password.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
                      "A 4-digit code has been sent to abdulrehman@gmail.com",
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
            TweenAnimationBuilder(
              tween: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero),
              duration: Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePassword(),
                        ),
                      );
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.8,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0.8, end: 1.0),
                              duration: Duration(milliseconds: 700),
                              curve: Curves.easeInOut,
                              builder: (context, double scale, child) {
                                return Transform.scale(
                                    scale: scale,
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Card(
                                        elevation: 2,
                                        child: Container(
                                          height: height * 0.06,
                                          width: width * 0.12,
                                        ),
                                      ),
                                    ));
                              },
                            );
                          }),
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
                    width: width * 0.3,
                    child: Center(
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 131, 235),
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
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
