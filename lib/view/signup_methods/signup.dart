import 'package:beautybazzle/controller/mycontroller.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/signup_methods/Signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<LOginSignupController>(builder: (obj) {
        return SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(StaticData.mybackground),
                  ),
                ),
                child: Form(
                  key: formKey,
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
                        tween: Tween<Offset>(
                            begin: Offset(0, 1), end: Offset.zero),
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
                              controller: obj.nameController,
                              icon: Icons.person,
                              hintText: "Name",
                              width: width,
                              height: height,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Name is required";
                                if (value.length < 3)
                                  return "Name must be at least 3 characters";
                                return null;
                              },
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
                              controller: obj.emailController,
                              icon: Icons.email,
                              hintText: "Email",
                              width: width,
                              height: height,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                // Basic email format validation
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
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
                              controller: obj.passwordController,
                              icon: Icons.password,
                              hintText: "Password",
                              width: width,
                              height: height,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters long";
                                }
                                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                  return "Password must include at least one uppercase letter";
                                }
                                if (!RegExp(r'[a-z]').hasMatch(value)) {
                                  return "Password must include at least one lowercase letter";
                                }
                                if (!RegExp(r'\d').hasMatch(value)) {
                                  return "Password must include at least one number";
                                }
                                if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                    .hasMatch(value)) {
                                  return "Password must include at least one special character";
                                }
                                return null;
                              },
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
                              controller: obj.phoneNumberController,
                              icon: Icons.phone,
                              hintText: "Phone Number",
                              width: width,
                              height: height,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Phone number is required";
                                }
                                if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                                  return "Enter a valid 11-digit phone number";
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),

                      // Checkbox with animation

                      Row(
                        children: [
                          SizedBox(width: width * 0.06),
                          Checkbox(
                            value: obj.isChecked,
                            onChanged: (value) {
                              obj.changeCheckStatus(value!, context);
                            },
                          ),
                          Text("Remember me",
                              style: TextStyle(fontSize: width * 0.04)),
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
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await obj.signUpUser(context);
                                }
                              },
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
                                    LOginSignupController.to.clearDAta();
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
              ),
              obj.isLoading
                  ? Container(
                      height: height,
                      width: width,
                      color: Colors.pink.withOpacity(0.3),
                      child: Center(
                          child: SpinKitSpinningLines(color: Colors.pink)),
                    )
                  : SizedBox()
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAnimatedTextField({
    required int index,
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required double width,
    required double height,
    String? Function(String?)? validator,
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
                obscureText: index == 2 ? !_passwordVisible : false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(icon),
                  suffixIcon: index == 2
                      ? IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )
                      : null,
                  filled: true,
                  hintText: hintText,
                ),
                validator: validator,
              ),
            ),
          ),
        );
      },
    );
  }

  bool _passwordVisible = false;
}
