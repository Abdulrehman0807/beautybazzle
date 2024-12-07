import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/Signin.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;

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
            SizedBox(height: height * 0.08),

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

            SizedBox(height: height * 0.02),

            // Register title with fade-in animation
            TweenAnimationBuilder(
              tween: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero),
              duration: Duration(milliseconds: 700),
              curve: Curves.easeOut,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: Container(
                    width: width * 0.83,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // Form fields with staggered animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: _buildAnimatedTextField(
                    index: 0,
                    controller: nameController,
                    icon: Icons.person,
                    hintText: "Name",
                    width: width,
                    height: height,
                  ),
                );
              },
            ),

            SizedBox(
              height: height * 0.01,
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: _buildAnimatedTextField(
                    index: 1,
                    controller: _emailController,
                    icon: Icons.email,
                    hintText: "Email",
                    width: width,
                    height: height,
                  ),
                );
              },
            ),

            SizedBox(
              height: height * 0.01,
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: _buildAnimatedTextField(
                    index: 2,
                    controller: _passwordController,
                    icon: Icons.password,
                    hintText: "Password",
                    width: width,
                    height: height,
                  ),
                );
              },
            ),

            SizedBox(
              height: height * 0.01,
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: _buildAnimatedTextField(
                    index: 3,
                    controller: _passwordController,
                    icon: Icons.phone,
                    hintText: "Phone Number",
                    width: width,
                    height: height,
                  ),
                );
              },
            ),

            // Checkbox with animation

            Row(
              children: [
                SizedBox(width: width * 0.06),
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text("Remember me", style: TextStyle(fontSize: width * 0.04)),
              ],
            ),

            // Sign up button with scale animation
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
                    onPressed: () {},
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // Already have an account link with fade-in animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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

  Widget _buildAnimatedTextField({
    required int index,
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required double width,
    required double height,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero),
      duration:
          Duration(milliseconds: 500 + (index * 100)), // Adding delay per field
      curve: Curves.easeOut,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
      },
    );
  }
}
