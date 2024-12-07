import 'package:beautybazzle/view/selectmethod.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<Introduction> list = [
    Introduction(
      titleTextStyle: TextStyle(fontSize: 27),
      title: 'Latest Styling Salon Here',
      subTitle: 'Centralized platform for Service Providers and Clients.',
      imageUrl: 'images/makeup1.png',
    ),
    Introduction(
      titleTextStyle: TextStyle(fontSize: 27),
      title: 'Interesting Tips and Tricks',
      subTitle: 'Make an appointment with a booking system for saving time.',
      imageUrl: 'images/makeup.png',
    ),
    Introduction(
      titleTextStyle: TextStyle(fontSize: 27),
      title: 'Cheaper and Worth It',
      subTitle: 'Unlock exclusive deals and discounts with us.',
      imageUrl: 'images/makeup3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      backgroudColor: Colors.white,
      foregroundColor: Colors.pink[200],
      skipTextStyle: TextStyle(color: Colors.pink[200], fontSize: 20),
      introductionList: list,
      onTapSkipButton: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedMethod(),
          ),
        );
      },
    );
  }
}
