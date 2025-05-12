import 'package:beautybazzle/view/orders/address.dart';
import 'package:beautybazzle/view/orders/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayOrderScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const PlayOrderScreen({super.key, required this.orderData});

  @override
  State<PlayOrderScreen> createState() => _PlayOrderScreenState();
}

class _PlayOrderScreenState extends State<PlayOrderScreen> {
  List<Map<String, dynamic>> addresses = [];
  List<Map<String, dynamic>> paymentCards = [];
  Map<String, dynamic>? selectedAddress;
  String? selectedCard;

  @override
  void initState() {
    super.initState();
    // Initialize with default data
    addresses = [
      {
        'type': 'Home',
        'name': 'John Doe',
        'address': '123 Main Street, Apartment 4B',
        'city': 'New York',
        'postalCode': '10001',
        'phone': '555-123-4567',
      },
      {
        'type': 'Work',
        'name': 'John Doe',
        'address': '456 Business Ave, Floor 5',
        'city': 'New York',
        'postalCode': '10002',
        'phone': '555-987-6543',
      }
    ];
    selectedAddress = addresses[0];

    paymentCards = [
      {
        'type': 'Visa',
        'name': 'John Doe',
        'cardNumber': '4242424242424242',
        'expiryDate': '12/25',
        'securityCode': '123',
        'postalCode': '10001',
        'nickName': 'My Visa Card',
      }
    ];
    selectedCard = paymentCards[0]['nickName'];
  }

  void _addNewAddress(Map<String, dynamic> newAddress) {
    setState(() {
      addresses.add(newAddress);
      selectedAddress = newAddress;
    });
  }

  void _addNewCard(Map<String, dynamic> newCard) {
    setState(() {
      paymentCards.add(newCard);
      selectedCard = newCard['nickName'];
    });
  }

  double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final subtotal = _toDouble(widget.orderData['subtotal']);
    final deliveryFee = _toDouble(widget.orderData['deliveryFee']);
    final total = _toDouble(widget.orderData['total']);
    final product = widget.orderData['product'] ?? {};

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
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
                  "Order Summery",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child:
                      const Icon(Icons.person, size: 26, color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Summary
                  _buildProductCard(width, product),
                  SizedBox(height: height * 0.03),

                  // Address Section
                  _buildAddressSection(height, width),
                  SizedBox(height: height * 0.03),

                  // Payment Method
                  _buildPaymentSection(width),
                  SizedBox(height: height * 0.03),

                  // Order Summary
                  _buildOrderSummary(width, subtotal, deliveryFee, total),
                ],
              ),
            ),
          ),

          // Bottom Checkout Bar
          _buildCheckoutBar(width, total),
        ],
      ),
    );
  }

  Widget _buildProductCard(double width, Map<String, dynamic> product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Row(
          children: [
            Container(
              width: width * 0.2,
              height: width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product['imageUrl'] ?? ''),
                ),
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? 'Product',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Quantity: ${product['quantity']}',
                    style: TextStyle(fontSize: width * 0.035),
                  ),
                ],
              ),
            ),
            Text(
              '\$${(product['price'] ?? 0).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address',
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.02),

        // Address List
        Column(
          children: addresses.map((address) {
            bool isSelected = selectedAddress == address;
            return GestureDetector(
              onTap: () => setState(() => selectedAddress = address),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.pink[200]! : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getAddressIcon(address['type']),
                      color: isSelected ? Colors.pink[200] : Colors.grey,
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address['type'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04,
                            ),
                          ),
                          Text(address['address']),
                          Text('${address['city']}, ${address['postalCode']}'),
                          Text(address['phone']),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle, color: Colors.pink[200]),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        // Add New Address Button
        SizedBox(height: height * 0.02),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewAddressScreen(
                  onSaveAddress: _addNewAddress,
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.pink[200],
            side: BorderSide(color: Colors.pink[200]!),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: Size(width * 0.9, height * 0.06),
          ),
          child: const Text('+ Add New Address'),
        ),
      ],
    );
  }

  IconData _getAddressIcon(String type) {
    switch (type) {
      case 'Work':
        return Icons.work;
      case 'Other':
        return Icons.location_city;
      default:
        return Icons.home;
    }
  }

  Widget _buildPaymentSection(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: width * 0.03),

        // Saved Cards
        ...paymentCards.map((card) {
          bool isSelected = selectedCard == card['nickName'];
          return GestureDetector(
            onTap: () => setState(() => selectedCard = card['nickName']),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.pink[200]! : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    _getCardIcon(card['type']),
                    color: isSelected ? Colors.pink[200] : Colors.grey,
                  ),
                  SizedBox(width: width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card['type'],
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '•••• •••• •••• ${card['cardNumber'].substring(card['cardNumber'].length - 4)}',
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                      Text(card['nickName']),
                    ],
                  ),
                  const Spacer(),
                  if (isSelected)
                    Icon(Icons.check_circle, color: Colors.pink[200]),
                ],
              ),
            ),
          );
        }).toList(),

        // Add New Card Button
        SizedBox(height: width * 0.03),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentMethodScreen(
                  onSaveCard: _addNewCard,
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.pink[200],
            side: BorderSide(color: Colors.pink[200]!),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: Size(width * 0.9, 50),
          ),
          child: const Text('+ Add New Card'),
        ),
      ],
    );
  }

  IconData _getCardIcon(String cardType) {
    switch (cardType) {
      case 'Visa':
        return FontAwesomeIcons.ccVisa;
      case 'MasterCard':
        return FontAwesomeIcons.ccMastercard;
      case 'American Express':
        return FontAwesomeIcons.ccAmex;
      default:
        return FontAwesomeIcons.creditCard;
    }
  }

  Widget _buildOrderSummary(
    double width,
    double subtotal,
    double deliveryFee,
    double total,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: width * 0.03),
        _buildSummaryRow('Subtotal', subtotal, width),
        _buildSummaryRow('Delivery Fee', deliveryFee, width),
        Divider(thickness: 1, height: 30),
        _buildSummaryRow('Total', total, width, isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double value, double width,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBar(double width, double total) {
    return Container(
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[300]!))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: width * 0.035),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.4,
            child: ElevatedButton(
              onPressed: _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                'PLACE ORDER',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    if (selectedAddress == null) {
      Fluttertoast.showToast(msg: 'Please select an address');
      return;
    }

    if (selectedCard == null) {
      Fluttertoast.showToast(msg: 'Please select a payment method');
      return;
    }

    final selectedCardData = paymentCards.firstWhere(
      (card) => card['nickName'] == selectedCard,
      orElse: () => {},
    );

    final completeOrder = {
      ...widget.orderData,
      'paymentMethod': selectedCardData,
      'address': selectedAddress,
      'status': 'Processing',
      'orderDate': DateTime.now().toIso8601String(),
    };

    // Here you would typically send the order to your backend
    print('Order placed: $completeOrder');

    // Navigate to order confirmation
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDoneScreen(orderData: completeOrder),
      ),
    );
  }
}

class OrderDoneScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDoneScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Order ID: ${orderData['orderId'] ?? 'N/A'}'),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                // padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
