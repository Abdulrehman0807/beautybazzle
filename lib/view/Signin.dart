import 'package:beautybazzle/view/bottom_Nav_bar.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/reset_pasword.dart';
import 'package:beautybazzle/view/signup.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
            SizedBox(height: height * 0.1),

            // Logo with Fade and Scale Animation
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

            SizedBox(height: height * 0.03),

            // Animated Form Fields and Buttons
            TweenAnimationBuilder(
              tween: Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.83,
                        child: Text("Login",
                            style: TextStyle(
                              fontSize: width * 0.07,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      SizedBox(height: height * 0.01),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.8, end: 1.0),
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        builder: (context, double scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: _buildTextField(
                                controller: _nameController,
                                icon: Icons.person,
                                hintText: "Name",
                                width: width,
                                height: height),
                          );
                        },
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.8, end: 1.0),
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        builder: (context, double scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: _buildTextField(
                                controller: _emailController,
                                icon: Icons.email,
                                hintText: "Email",
                                width: width,
                                height: height),
                          );
                        },
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.8, end: 1.0),
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        builder: (context, double scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: _buildTextField(
                                controller: _passwordController,
                                icon: Icons.password,
                                hintText: "Password",
                                width: width,
                                height: height),
                          );
                        },
                      ),
                      SizedBox(height: height * 0.015),

                      // Forgot Password Link
                      Container(
                        width: width * 0.83,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordScreen(),
                                    ));
                              },
                              child: Text("Forget Password?",
                                  style: TextStyle(fontSize: width * 0.045)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      // Sign In Button with Animation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.8, end: 1.0),
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        builder: (context, double scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink[200],
                                minimumSize: Size(width * 0.83, height * 0.055),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavBar(),
                                    ));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: height * 0.01),

                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(fontSize: width * 0.04)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required double width,
    required double height,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.005),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: height * 0.055,
          width: width * 0.85,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              filled: true,
              hintText: hintText,
            ),
          ),
        ),
      ),
    );
  }
}
