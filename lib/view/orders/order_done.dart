// import 'package:beautybazzle/view/dashboard/Dashboard.dart';
import 'package:beautybazzle/view/dashboard/Dashboard.dart';
import 'package:flutter/material.dart';

class OrderDoneScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;
  
  const OrderDoneScreen({super.key, required this.orderData});

  @override
  State<OrderDoneScreen> createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final total = widget.orderData['total']?.toStringAsFixed(2) ?? '0.00';
    final orderNumber = widget.orderData['orderDate']?.substring(0, 10) ?? '';

    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        builder: (context, double opacity, child) {
          return Opacity(
            opacity: opacity,
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSuccessIcon(size),
                      SizedBox(height: size.height * 0.03),
                      _buildThankYouMessage(size),
                      SizedBox(height: size.height * 0.05),
                      _buildOrderDetails(size, total, orderNumber),
                      SizedBox(height: size.height * 0.05),
                      _buildHomeButton(size, context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccessIcon(Size size) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: CircleAvatar(
            radius: size.width * 0.2,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.check_circle,
              size: size.width * 0.3,
              color: const Color.fromARGB(255, 252, 128, 169),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThankYouMessage(Size size) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: Text(
            "Thank You For Your Order!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderDetails(Size size, String total, String orderNumber) {
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(size, "Order Number:", "#$orderNumber"),
          Divider(color: Colors.grey[300]),
          _buildDetailRow(size, "Total Amount:", "\$$total"),
          Divider(color: Colors.grey[300]),
          _buildDetailRow(
            size, 
            "Payment Method:", 
            widget.orderData['paymentMethod'] ?? 'Not specified'
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(Size size, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton(Size size, BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>  DashboardScreen(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 252, 128, 169),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Back to Home",
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}