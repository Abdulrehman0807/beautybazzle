import 'package:beautybazzle/model/addsalon/addsalon.dart';
import 'package:beautybazzle/model/signup_login/signup_model.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/bottom_bar/bottom_Nav_bar.dart';
import 'package:beautybazzle/view/introduction/intro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
      value: 0.1,
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic);
    controller.forward();

    // Navigate to the Intro screen after 3 seconds
    checkLoginState();
  }

// Check login state on app launch
  Future<void> checkLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final String? userId = prefs.getString('userId');

    if (isLoggedIn && userId != null) {
      // Fetch user data from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();

      QuerySnapshot snapshot1 = await FirebaseFirestore.instance
          .collection("salons")
          .where("userId", isEqualTo: userId)
          .get();

      if (snapshot1.docs.isNotEmpty) {
        SalonModel model =
            SalonModel.fromMap(snapshot.data() as Map<String, dynamic>);
        StaticData.salonModel = model;
      }
      if (snapshot.exists) {
        UserModels model =
            UserModels.fromMap(snapshot.data() as Map<String, dynamic>);
        StaticData.userModel = model;

        // Navigate to home screen
        // (() => BottomNavBar());
      }
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroScreen(),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(StaticData.mybackground))),
        child: Center(
          child: ScaleTransition(
            scale: animation,
            alignment: Alignment.center,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(StaticData.myLogo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
