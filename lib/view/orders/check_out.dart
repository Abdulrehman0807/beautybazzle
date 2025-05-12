import 'package:beautybazzle/view/orders/play_order.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const CheckoutScreen({super.key, required this.product});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final double deliveryFee = 2.0;
  double subtotal = 0.0;
  late Map<String, dynamic> product;

  // Helper method to safely convert to double
  double _parsePrice(dynamic price) {
    if (price is double) return price;
    if (price is int) return price.toDouble();
    if (price is String) return double.tryParse(price) ?? 0.0;
    return 0.0;
  }

  // Helper method to safely convert to int
  int _parseQuantity(dynamic quantity) {
    if (quantity is int) return quantity;
    if (quantity is double) return quantity.toInt();
    if (quantity is String) return int.tryParse(quantity) ?? 1;
    return 1;
  }

  @override
  void initState() {
    super.initState();
    product = Map<String, dynamic>.from(widget.product);
    product['quantity'] = _parseQuantity(product['quantity']);
    product['price'] = _parsePrice(product['price']);
    updateSubtotal();
  }

  void updateSubtotal() {
    setState(() {
      subtotal = product['price'] * product['quantity'];
    });
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
                // Header (unchanged)
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TweenAnimationBuilder(
                          duration: Duration(milliseconds: 500),
                          tween: Tween<double>(begin: 0.8, end: 1.0),
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
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage("images/product.jpg"),
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
                                            product["description"] ??
                                                "",
                                            style: TextStyle(
                                              fontSize: width * 0.03,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          // Price - FIXED VERSION
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
                                          // Quantity Controls
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // Decrement Button
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (product["quantity"] >
                                                        1) {
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
                                                  product["quantity"]
                                                      .toString(),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Footer (unchanged)
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
                    // Price Summary
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
                        _placeOrder(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.015),
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

  void _placeOrder(BuildContext context) {
    // Prepare order data
    final orderData = {
      'product': product,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': subtotal + deliveryFee,
      'orderDate': DateTime.now().toString(),
    };

    Fluttertoast.showToast(
      msg: "Order Placed Successfully!",
      toastLength: Toast.LENGTH_LONG,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayOrderScreen(orderData: orderData),
      ),
    );
  }
}
