import 'package:beautybazzle/view/Dashboard.dart';
import 'package:flutter/material.dart';

class OrderDoneScreen extends StatefulWidget {
  const OrderDoneScreen({super.key});

  @override
  State<OrderDoneScreen> createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        builder: (context, double opacity, child) {
          return Opacity(
            opacity: opacity,
            child: Container(
              height: height,
              width: width,
              color: Colors.white,
              child: Center(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.8, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  builder: (context, double scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: _buildContent(height, width, context),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(double height, double width, BuildContext context) {
    return Container(
      height: height * 0.4,
      width: width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.task_alt,
                    size: width * 0.3,
                    color: Colors.pink[200],
                  ),
                ),
              );
            },
          ),
          TweenAnimationBuilder(
            tween: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            builder: (context, Offset offset, child) {
              return Transform.translate(
                offset: offset,
                child: Container(
                  height: height * 0.12,
                  width: width * 0.6,
                  child: Text(
                    "Thank You For \n your Order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ));
            },
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Back to Home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
