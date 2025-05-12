import 'package:beautybazzle/model/signup_login/signup_model.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/bottom_bar/bottom_Nav_bar.dart';
import 'package:beautybazzle/view/signup_methods/Signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LOginSignupController extends GetxController {
  static LOginSignupController get to => Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController salonDescriptionController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController profilePictureController =
      TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();

  bool isLoading = false;
  bool isChecked = false;

  @override
  void onInit() {
    super.onInit();
    //checkLoginState(); // Check login state when the controller is initialized
  }

  changeLoadingStatus(bool v) {
    isLoading = v;
    update();
  }

  clearDAta() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneNumberController.clear();
    salonNameController.clear();
    salonDescriptionController.clear();
    facebookController.clear();
    youtubeController.clear();
    instagramController.clear();
    tiktokController.clear();
    aboutMeController.clear();
    profilePictureController.clear();
    update();
  }

  changeCheckStatus(bool v, BuildContext context) {
    isChecked = v;
    if (isChecked) {
      if (nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        _showDialog(nameController.text, emailController.text,
            passwordController.text, context);
      } else {
        Fluttertoast.showToast(
          msg: "Please fill out all fields before saving credentials.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
    update();
  }

  Future<void> handleSignIn(BuildContext context) async {
    changeLoadingStatus(true);

    try {
      // Normalize email to lowercase for case-insensitive comparison
      String emailLowercase = emailController.text.toLowerCase();

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where("email", isEqualTo: emailLowercase)
          .where("password", isEqualTo: passwordController.text)
          .get();

      if (snapshot.docs.isEmpty) {
        Fluttertoast.showToast(
            msg: "Incorrect Email or Password.",
            backgroundColor: Colors.pink[200]);
        changeLoadingStatus(false);
      } else {
        UserModels model =
            UserModels.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
        StaticData.userModel = model;

        // Save login state and user details
        await _saveLoginState(true, model.UserId);

        Fluttertoast.showToast(
            msg: "Login Successfully", backgroundColor: Colors.pink[200]);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ));
        changeLoadingStatus(false);
        clearDAta();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
    } finally {
      changeLoadingStatus(false);
    }
  }

  // Future<void> signUpUser(BuildContext context) async {
  //   Fluttertoast.showToast(
  //     msg: "Please fix the errors in the form",
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: Colors.redAccent,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );

  //   String email = emailController.text.trim();
  //   String name = nameController.text.trim();
  //   String password = passwordController.text.trim();
  //   String phoneNumber = phoneNumberController.text.trim();
  //   String address = addressController.text.trim();
  //   String profilePicture = profilePictureController.text.trim();
  //   String youtube = youtubeController.text.trim();
  //   String facebook = facebookController.text.trim();
  //   String instagram = instagramController.text.trim();
  //   String tiktok = tiktokController.text.trim();
  //   String aboutMe = aboutMeController.text.trim();

  //   changeLoadingStatus(true);

  //   try {
  //     QuerySnapshot existingUser = await FirebaseFirestore.instance
  //         .collection("Users")
  //         .where("email", isEqualTo: email)
  //         .get();

  //     if (existingUser.docs.isNotEmpty) {
  //       Fluttertoast.showToast(
  //         msg: "This email is already registered",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.orangeAccent,
  //         textColor: Colors.black,
  //         fontSize: 16.0,
  //       );

  //       changeLoadingStatus(false);
  //       return;
  //     }

  //     var uuid = const Uuid();
  //     String userId = uuid.v4();

  //     UserModels model = UserModels(
  //       name: name,
  //       email: email,
  //       password: password,
  //       PhoneNumber: phoneNumber,
  //       UserId: userId,
  //       Address: address,
  //       ProfilePicture: profilePicture,
  //       YouTube: youtube,
  //       Facebook: facebook,
  //       Instagram: instagram,
  //       TikTok: tiktok,
  //       AboutMe: aboutMe,
  //     );
  //     await FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(userId)
  //         .set(model.toMap());

  //     Fluttertoast.showToast(
  //       msg: "User registered successfully!",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //     StaticData.userModel = model;

  //     // Save login state and user details
  //     await _saveLoginState(true, model.UserId);

  //     clearDAta();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => BottomNavBar(),
  //       ),
  //     );
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Error registering user: $e",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   } finally {
  //     changeLoadingStatus(false);
  //   }
  // }
  Future<void> signUpUser(BuildContext context) async {
    // Show initial toast message indicating form errors
    Fluttertoast.showToast(
      msg: "Please fix the errors in the form",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Collect form data
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String address = addressController.text.trim();
    String profilePicture = profilePictureController.text.trim();
    String youtube = youtubeController.text.trim();
    String facebook = facebookController.text.trim();
    String instagram = instagramController.text.trim();
    String tiktok = tiktokController.text.trim();
    String aboutMe = aboutMeController.text.trim();

    // Show loading status
    changeLoadingStatus(true);

    try {
      // Check if the email is already registered in Firestore
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

        changeLoadingStatus(false);
        return;
      }

      // Create user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Once the user is created, retrieve their User ID (UID)
      String userId = userCredential.user?.uid ?? '';

      // If the UID is empty, handle the error
      if (userId.isEmpty) {
        Fluttertoast.showToast(
          msg: "Error registering user: Invalid user ID",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        changeLoadingStatus(false);
        return;
      }

      // Create a user model and store it in Firestore
      UserModels model = UserModels(
        name: name,
        email: email,
        password: password,
        PhoneNumber: phoneNumber,
        UserId: userId,
        Address: address,
        ProfilePicture: profilePicture,
        YouTube: youtube,
        Facebook: facebook,
        Instagram: instagram,
        TikTok: tiktok,
        AboutMe: aboutMe,
      );

      // Store user data in Firestore
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

      StaticData.userModel = model;

      // Save login state and user details
      await _saveLoginState(true, model.UserId);

      clearDAta();

      // Navigate to the next page after successful registration
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      );
    } catch (e) {
      // Show error message in case of failure
      Fluttertoast.showToast(
        msg: "Error registering user: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      // Reset loading state
      changeLoadingStatus(false);
    }
  }

  Future<void> saveCredentials(
      String name, String email, String password, BuildContext context) async {
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

  Future<void> _showDialog(
      String name, String email, String password, BuildContext context) async {
    showDialog(
      context: context,
      builder: (dcontext) {
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
                saveCredentials(name, email, password, context);
                Navigator.pop(context); // Close dialog after saving
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkSavedCredentials(BuildContext context) async {
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
          nameController.text = savedName;
          emailController.text = savedEmail;
          passwordController.text = savedPassword;
          update();
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

  // Save login state and user ID
  Future<void> _saveLoginState(bool isLoggedIn, String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('userId', userId);
  }

  // Logout functionality
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userId');
    StaticData.userModel = null; // Clear user data
    Get.offAll(() => SigninScreen()); // Navigate to login screen
  }
}
