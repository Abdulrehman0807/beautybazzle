import 'package:flutter/material.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key});

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 600),
        builder: (context, double opacity, child) {
          return Opacity(
            opacity: opacity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  _buildAppBar(width, context),
                  SizedBox(height: height * 0.08),
                  _buildCardForm(height, width),
                  SizedBox(height: height * 0.02),
                  _buildAddCardButton(height, width),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(double width, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        Text(
          "Add Address",
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: const Icon(Icons.credit_card, size: 26, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildCardForm(double height, double width) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            padding: EdgeInsets.all(width * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInputField("Name ", Icons.person, TextInputType.name),
                _buildInputField(
                    "Address Lane", Icons.location_pin, TextInputType.number),
                _buildInputField(
                    "City", Icons.location_pin, TextInputType.number),
                _buildInputField(
                    "Postal Code", Icons.password, TextInputType.number),
                _buildInputField(
                    "Phone Number", Icons.phone, TextInputType.text),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(
      String label, IconData icon, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                ),
                hintText: "Enter $label",
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              keyboardType: keyboardType,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton(double height, double width) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: 1.1),
        duration: const Duration(milliseconds: 300),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              height: height * 0.05,
              width: width * 0.3,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Add Address",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
