import 'package:beautybazzle/model/signup_model.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/Signin.dart';
import 'package:beautybazzle/view/bottom_Nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _salonNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  bool isLoading = false;

  Future<void> signUpUser() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Please fix the errors in the form",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    String email = _emailController.text.trim();
    String name = nameController.text.trim();
    String password = _passwordController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String salonName = _salonNameController.text.trim();
    String address = _addressController.text.trim();
    String profilePicture = _profilePictureController.text.trim(); // Store URL
    String youtube = _youtubeController.text.trim();
    String facebook = _facebookController.text.trim();
    String instagram = _instagramController.text.trim();
    String tiktok = _tiktokController.text.trim();
    String aboutMe = _aboutMeController.text.trim();

    setState(() {
      isLoading = true;
    });

    try {
      QuerySnapshot existingUser = await FirebaseFirestore.instance
          .collection("Users")
          .where("email", isEqualTo: email)
          .get();

      if (existingUser.docs.isNotEmpty) {
        Fluttertoast.showToast(
          msg: "This email is already registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      var uuid = const Uuid();
      String userId = uuid.v4();

      UserModels model = UserModels(
        name: name,
        email: email,
        password: password,
        PhoneNumber: phoneNumber,
        UserId: userId,
        SalonName: salonName,
        Address: address,
        ProfilePicture: profilePicture,
        YouTube: youtube,
        Facebook: facebook,
        Instagram: instagram,
        TikTok: tiktok,
        AboutMe: aboutMe,
      );

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .set(model.toMap());

      Fluttertoast.showToast(
        msg: "User registered successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error registering user: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveCredentials(
      String name, String email, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Credentials saved successfully!")),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error saving credentials: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _showDialog(String name, String email, String password) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Save Credentials?"),
          content: const Text(
              "Do you want to save your name, email, and password for future logins?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog without saving
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _saveCredentials(name, email, password);
                Navigator.pop(context); // Close dialog after saving
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkSavedCredentials() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedName = prefs.getString('name');
      final String? savedEmail = prefs.getString('email');
      final String? savedPassword = prefs.getString('password');

      if (savedName != null && savedEmail != null && savedPassword != null) {
        final bool useSaved = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Use Saved Credentials?"),
                  content: const Text(
                      "Do you want to use your saved name, email, and password?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context, false); // Don't use saved credentials
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true); // Use saved credentials
                      },
                      child: const Text("Use"),
                    ),
                  ],
                );
              },
            ) ??
            false;

        if (useSaved) {
          setState(() {
            nameController.text = savedName;
            _emailController.text = savedEmail;
            _passwordController.text = savedPassword;
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error retrieving saved credentials: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

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
        child: Form(
          key: _formKey,
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
                      controller: _emailController,
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
                      controller: _passwordController,
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
                      controller: _phoneNumberController,
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
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                      if (isChecked) {
                        if (nameController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          _showDialog(
                            nameController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg:
                                "Please fill out all fields before saving credentials.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      }
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
                      onPressed: () async {
                        await signUpUser();
                      },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(icon),
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
}
