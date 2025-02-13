import 'package:beautybazzle/view/orders/play_order.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, dynamic> product = {
    "name": "Fizza Beauty Cream",
    "price": 6.0,
    "quantity": 1,
  };

  final double deliveryFee = 2.0; // Flat delivery fee
  double subtotal = 0.0;

  @override
  void initState() {
    super.initState();
    updateSubtotal();
  }

  // Update subtotal based on quantity
  void updateSubtotal() {
    subtotal = product["price"] * product["quantity"];
    setState(() {}); // Update UI
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: height * 0.03),
                // Header
                Container(
                  height: height * 0.09,
                  width: width * 0.99,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.shopping_bag,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Product Details
                Expanded(
                  child: Column(
                    children: [
                      TweenAnimationBuilder(
                        duration: Duration(milliseconds: 500),
                        tween: Tween<double>(
                            begin: 0.8, end: 1.0), // Scaling effect
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: 1.0,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              height: height * 0.15,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Product Image
                                  Container(
                                    height: height * 0.13,
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("images/product.jpg"),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  // Product Info
                                  Container(
                                    height: height * 0.13,
                                    width: width * 0.55,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Product Name
                                        Text(
                                          product["name"],
                                          style: TextStyle(
                                            fontSize: width * 0.045,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        // Product Description
                                        Text(
                                          "A nourishing cream that brightens, hydrates, and smooths skin for a radiant glow.",
                                          style: TextStyle(
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Price
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\$ ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: width * 0.039,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: (product["price"] *
                                                        product["quantity"])
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: width * 0.034,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Increment/Decrement
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Decrement Button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (product["quantity"] > 1) {
                                                    product["quantity"]--;
                                                    updateSubtotal();
                                                  }
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 13,
                                                backgroundColor:
                                                    Colors.pink[200],
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            // Quantity Display
                                            CircleAvatar(
                                              radius: 13,
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                product["quantity"].toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            // Increment Button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  product["quantity"]++;
                                                  updateSubtotal();
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 13,
                                                backgroundColor:
                                                    Colors.pink[200],
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Footer
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.1,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Subtotal and Delivery Fee
                    Container(
                      height: height * 0.07,
                      width: width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subtotal
                          Row(
                            children: [
                              Text(
                                "Subtotal : ",
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "\$${subtotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          // Delivery Fee
                          Row(
                            children: [
                              Text(
                                "Delivery Fee : ",
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "\$${deliveryFee.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          // Total
                          Row(
                            children: [
                              Text(
                                "Total : ",
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${(subtotal + deliveryFee).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Place Order Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayOrderScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 252, 128, 169),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Place Order",
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
            ),
          ],
        ),
      ),
    );
  }
}
