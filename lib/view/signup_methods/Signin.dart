import 'package:beautybazzle/controller/signup/mycontroller.dart';
import 'package:flutter/material.dart';
import 'package:beautybazzle/view/changepassword/reset_pasword.dart';
import 'package:beautybazzle/view/signup_methods/signup.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Get.put(LOginSignupController());
    super.initState();
  }

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
                      SizedBox(height: height * 0.1),

                      // Logo with Animation
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

                      // Fields and Buttons
                      Column(
                        children: [
                          SizedBox(height: height * 0.01),

                          Container(
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
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          _buildAnimatedTextField(
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
                              return null;
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
                                      style: TextStyle(fontSize: width * 0.04)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.025),

                          // Sign In Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink[200],
                              minimumSize: Size(width * 0.83, height * 0.055),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await obj.handleSignIn(context);
                              }
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.015),

                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?",
                                  style: TextStyle(fontSize: width * 0.04)),
                              TextButton(
                                onPressed: () {
                                  LOginSignupController.to.clearDAta();
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
                    ],
                  ),
                ),
              ),
              obj.isLoading
                  ? Container(
                      height: height,
                      width: width,
                      color: Colors.pink.withOpacity(0.3),
                      child: const Center(
                          child: SpinKitSpinningLines(color: Colors.pink)),
                    )
                  : const SizedBox()
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
    required String? Function(String?) validator,
  }) {
    return Card(
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
    );
  }

  bool _passwordVisible = false;
}
