import 'package:beautybazzle/model/signup_model.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/bottom_bar/bottom_Nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LOginSignupController extends GetxController {
  static LOginSignupController get to => Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController profilePictureController =
      TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController salonDescriptionController =
      TextEditingController();

  bool isLoading = false;
  bool isChecked = false;
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
          .where("email",
              isEqualTo:
                  emailLowercase) // Use the lowercase version of the email
          .where("password",
              isEqualTo: passwordController
                  .text) // Keep password as it is (case-sensitive)
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

  Future<void> signUpUser(BuildContext context) async {
    Fluttertoast.showToast(
      msg: "Please fix the errors in the form",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );

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

    changeLoadingStatus(true);

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

        changeLoadingStatus(false);
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
      StaticData.userModel = model;
      clearDAta();
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
}
