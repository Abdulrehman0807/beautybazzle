import 'package:beautybazzle/controller/signinmethod/selectedsignupcontoller.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/signup_methods/Signin.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SelectedMethod extends StatefulWidget {
  const SelectedMethod({super.key});

  @override
  State<SelectedMethod> createState() => _SelectedMethodState();
}

class _SelectedMethodState extends State<SelectedMethod> {
  @override
  void initState() {
    Get.put(SelectedSignupContoller());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<SelectedSignupContoller>(builder: (obj) {
        return SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.5,
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(StaticData.mybackground),
                        ),
                      ),
                      child: TweenAnimationBuilder(
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
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: height * 0.57,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: height * 0.009,
                            ),
                            _buildAnimatedText(
                              "Sign up or Log in ",
                              width * 0.055,
                              FontWeight.w700,
                            ),
                            _buildAnimatedText(
                              "Select your preferred method to continue ",
                              width * 0.035,
                              FontWeight.w400,
                            ),
                            _buildAnimatedButtonGoogle(
                              "Continue with Google",
                              FontAwesomeIcons.google,
                              Colors.red,
                              width,
                              height,
                            ),
                            _buildAnimatedButtonFacebook(
                              "Continue with Facebook",
                              FontAwesomeIcons.facebook,
                              Colors.blue,
                              width,
                              height,
                            ),
                            _buildAnimatedButtonApple(
                              "Continue with Apple",
                              FontAwesomeIcons.apple,
                              Colors.grey,
                              width,
                              height,
                            ),
                            _buildOrDivider(width),
                            _buildEmailButton(width, height),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              obj.isLoading
                  ? Container(
                      height: height,
                      width: width,
                      color: Colors.pink.withOpacity(0.3),
                      child: Center(
                          child: CircularProgressIndicator(color: Colors.pink)),
                    )
                  : SizedBox()
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAnimatedText(
      String text, double fontSize, FontWeight fontWeight) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Container(
            height: 40,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButtonGoogle(
    String text,
    IconData icon,
    Color iconColor,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        SelectedSignupContoller.to.signInWithGoogle;
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.8, end: 1.0),
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              height: height * 0.06,
              width: width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: FaIcon(
                      icon,
                      size: width * 0.07,
                      color: iconColor,
                    ),
                    onPressed: () {
                      // Define what happens on icon press
                    },
                  ),
                  SizedBox(width: width * 0.08),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedButtonFacebook(
    String text,
    IconData icon,
    Color iconColor,
    double width,
    double height,
  ) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            height: height * 0.06,
            width: width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: FaIcon(
                    icon,
                    size: width * 0.07,
                    color: iconColor,
                  ),
                  onPressed: () {
                    // Define what happens on icon press
                  },
                ),
                SizedBox(width: width * 0.08),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButtonApple(
    String text,
    IconData icon,
    Color iconColor,
    double width,
    double height,
  ) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            height: height * 0.06,
            width: width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: FaIcon(
                    icon,
                    size: width * 0.07,
                    color: iconColor,
                  ),
                  onPressed: () {
                    // Define what happens on icon press
                  },
                ),
                SizedBox(width: width * 0.08),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButton(
    String text,
    IconData icon,
    Color iconColor,
    double width,
    double height,
  ) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            height: height * 0.06,
            width: width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: FaIcon(
                    icon,
                    size: width * 0.07,
                    color: iconColor,
                  ),
                  onPressed: () {
                    // Define what happens on icon press
                  },
                ),
                SizedBox(width: width * 0.08),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrDivider(double width) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: width * 0.6,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 1,
              endIndent: width * 0.02,
            ),
          ),
          Text(
            "or",
            style: TextStyle(
              fontSize: width * 0.045,
              color: Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 1,
              indent: width * 0.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailButton(double width, double height) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SigninScreen(),
          ),
        );
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.8, end: 1.0),
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              height: height * 0.06,
              width: width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: width * 0.08),
                  Expanded(
                    child: Text(
                      "Continue with Email",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
