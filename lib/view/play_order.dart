import 'package:beautybazzle/view/address.dart';
import 'package:beautybazzle/view/order_done.dart';
import 'package:beautybazzle/view/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayOrderScreen extends StatefulWidget {
  const PlayOrderScreen({super.key});

  @override
  State<PlayOrderScreen> createState() => _PlayOrderScreenState();
}

class _PlayOrderScreenState extends State<PlayOrderScreen> {
  String? selectedCard;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: height * 0.03),
              Header(title: "Order Play", icon: Icons.task_alt),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      AddressSection(height: height, width: width),
                      SizedBox(height: height * 0.02),
                      PaymentMethodSection(
                        height: height,
                        width: width,
                        selectedCard: selectedCard,
                        onCardSelected: (value) {
                          setState(() {
                            selectedCard = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      AddcardButton(
                        label: "+ Add Card",
                        width: width,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentMethodScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BottomBar(
            height: height,
            width: width,
            totalPrice: "\$600.00",
            onPlayNow: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDoneScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final IconData icon;

  const Header({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Icon(icon, size: 24, color: Colors.black),
        ],
      ),
    );
  }
}

class AddressSection extends StatelessWidget {
  final double height;
  final double width;

  const AddressSection({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: "Address", width: width),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: height * 0.05,
                      backgroundColor: Colors.black12,
                      child: Icon(FontAwesomeIcons.locationDot,
                          color: Colors.black, size: width * 0.08),
                    ),
                    SizedBox(
                      width: width * 0.6,
                      child: ListTile(
                        title: Text(
                          "Home",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          "Qasba Gujrat District Muzaffargarh",
                          style: TextStyle(fontSize: width * 0.035),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: height * 0.01,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewAddressScreen(),
              ),
            );
          },
          child: AddcardButton(
            label: "+ Add new address",
            width: width,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewAddressScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  final double height;
  final double width;
  final String? selectedCard;
  final ValueChanged<String?> onCardSelected;

  const PaymentMethodSection({
    required this.height,
    required this.width,
    required this.selectedCard,
    required this.onCardSelected,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {"name": "Visa Card", "image": "images/visa.png"},
      {"name": "Master Card", "image": "images/mastercard.png"},
      {"name": "Cash on Delivery", "image": "images/cashondelivery.jpg"},
    ];

    return Column(
      children: [
        SectionTitle(title: "Payment Method", width: width),
        ...paymentMethods.map((method) {
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 50),
                  child: PaymentMethodCard(
                    name: method["name"]!,
                    imagePath: method["image"]!,
                    isSelected: selectedCard == method["name"],
                    onSelected: () => onCardSelected(method["name"]),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ],
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onSelected;

  const PaymentMethodCard({
    required this.name,
    required this.imagePath,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onSelected,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.pink : Colors.black12,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(imagePath),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle,
                    color: Color.fromARGB(255, 252, 128, 169))
              else
                const Icon(Icons.circle_outlined, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

class AddcardButton extends StatelessWidget {
  final String label;
  final double width;
  final VoidCallback onPressed;

  const AddcardButton({
    required this.label,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height * 0.05,
        width: width * 0.8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Color.fromARGB(255, 252, 128, 169)),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final double width;

  const SectionTitle({required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: width * 0.9,
      child: Text(
        title,
        style: TextStyle(
          fontSize: width * 0.045,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final double height;
  final double width;
  final String totalPrice;
  final VoidCallback onPlayNow;

  const BottomBar({
    required this.height,
    required this.width,
    required this.totalPrice,
    required this.onPlayNow,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(20),
        height: height * 0.1,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: $totalPrice",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onPlayNow,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 252, 128, 169),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Play Now",
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
