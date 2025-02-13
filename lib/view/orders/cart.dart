import 'package:beautybazzle/view/orders/check_out.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Fizza Beauty Cream",
      "price": 6.0,
      "quantity": 1,
      "isChecked": false
    },
    {"name": "Rose Serum", "price": 8.0, "quantity": 1, "isChecked": false},
    {
      "name": "Glow Face Mask",
      "price": 12.0,
      "quantity": 1,
      "isChecked": false
    },
    {
      "name": "Hydration Lotion",
      "price": 10.0,
      "quantity": 1,
      "isChecked": false
    },
    {
      "name": "Vitamin C Cream",
      "price": 15.0,
      "quantity": 1,
      "isChecked": false
    },
  ];

  bool selectAll = false;
  double subtotal = 0.0;
  final double deliveryFee = 5.0;

  // Update subtotal
  void updateSubtotal() {
    subtotal = 0.0;
    for (var item in cartItems) {
      if (item["isChecked"]) {
        subtotal += item["price"] * item["quantity"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
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
                    width: width * 0.96,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Text(
                          "My Cart",
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.shopping_bag,
                              size: 24, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // Select All
                  Container(
                    height: height * 0.05,
                    child: Row(
                      children: [
                        Checkbox(
                          value: selectAll,
                          onChanged: (value) {
                            setState(() {
                              selectAll = value!;
                              for (var item in cartItems) {
                                item["isChecked"] = selectAll;
                              }
                              updateSubtotal();
                            });
                          },
                        ),
                        Text("Select All"),
                      ],
                    ),
                  ),
                  // Cart Items with Animations
                  Expanded(
                    child: Container(
                        height: cartItems.length * height * 0.15,
                        width: width,
                        child: TabBarView(children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: cartItems.map((item) {
                                // var item = cartItems[index];
                                return TweenAnimationBuilder(
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
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        height: height * 0.15,
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Checkbox
                                              Checkbox(
                                                value: item["isChecked"],
                                                onChanged: (value) {
                                                  setState(() {
                                                    item["isChecked"] = value!;
                                                    selectAll = cartItems.every(
                                                        (item) =>
                                                            item["isChecked"]);
                                                    updateSubtotal();
                                                  });
                                                },
                                              ),
                                              // Product Image
                                              Container(
                                                height: height * 0.12,
                                                width: width * 0.28,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "images/product.jpg"),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              // Product Details
                                              Container(
                                                height: height * 0.13,
                                                width: width * 0.45,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item["name"],
                                                      style: TextStyle(
                                                        fontSize: width * 0.045,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      "A wonderful product.",
                                                      style: TextStyle(
                                                        fontSize: width * 0.03,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    // Price
                                                    RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                          text: "\$ ",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                width * 0.039,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: item["price"]
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                width * 0.034,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                    // Increment/Decrement
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        // Decrement Button
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (item[
                                                                      "quantity"] >
                                                                  1)
                                                                item[
                                                                    "quantity"]--;
                                                              updateSubtotal();
                                                            });
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 12,
                                                            backgroundColor:
                                                                Colors
                                                                    .pink[200],
                                                            child: Icon(
                                                                Icons.remove,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        // Quantity
                                                        Text(
                                                          item["quantity"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        // Increment Button
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              item[
                                                                  "quantity"]++;
                                                              updateSubtotal();
                                                            });
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 12,
                                                            backgroundColor:
                                                                Colors
                                                                    .pink[200],
                                                            child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Remove Product
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    cartItems.remove(item);
                                                    updateSubtotal();
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  radius: 16,
                                                  backgroundColor: Colors.white,
                                                  child: Icon(Icons.close,
                                                      size: 22,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ])),
                  ),

                  SizedBox(height: height * 0.1),
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
                    border:
                        Border.all(color: Colors.black12, width: width * 0.005),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Subtotal
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subtotal:  \$${subtotal.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Delivery Fee:  \$${deliveryFee.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Total:  \$${(subtotal + deliveryFee).toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // Checkout Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen()),
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
                            "Check Out",
                            style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
