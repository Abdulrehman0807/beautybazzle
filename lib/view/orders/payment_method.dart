// import 'package:flutter/material.dart';

// class PaymentMethodScreen extends StatefulWidget {
//   const PaymentMethodScreen({super.key});

//   @override
//   State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
// }

// class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: TweenAnimationBuilder(
//         tween: Tween<double>(begin: 0.0, end: 1.0),
//         duration: const Duration(milliseconds: 600),
//         builder: (context, double opacity, child) {
//           return Opacity(
//             opacity: opacity,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//               child: Column(
//                 children: [
//                   SizedBox(height: height * 0.05),
//                   _buildAppBar(width, context),
//                   SizedBox(height: height * 0.08),
//                   _buildCardForm(height, width),
//                   SizedBox(height: height * 0.02),
//                   _buildAddCardButton(height, width),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildAppBar(double width, BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         InkWell(
//           onTap: () => Navigator.pop(context),
//           child: CircleAvatar(
//             radius: 18,
//             backgroundColor: Colors.white,
//             child: const Icon(Icons.arrow_back, color: Colors.black),
//           ),
//         ),
//         Text(
//           "Add Card",
//           style: TextStyle(
//             fontSize: width * 0.05,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         CircleAvatar(
//           radius: 20,
//           backgroundColor: Colors.white,
//           child: const Icon(Icons.credit_card, size: 26, color: Colors.black),
//         ),
//       ],
//     );
//   }

//   Widget _buildCardForm(double height, double width) {
//     return TweenAnimationBuilder(
//       tween: Tween<double>(begin: 0.8, end: 1.0),
//       duration: const Duration(milliseconds: 700),
//       curve: Curves.easeOut,
//       builder: (context, double scale, child) {
//         return Transform.scale(
//           scale: scale,
//           child: Container(
//             padding: EdgeInsets.all(width * 0.05),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 _buildInputField(
//                     "Name on Card", Icons.credit_card, TextInputType.name),
//                 _buildInputField(
//                     "Card Number", Icons.dialpad, TextInputType.number),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildInputField("Expiry Date",
//                           Icons.calendar_today, TextInputType.datetime),
//                     ),
//                     SizedBox(width: width * 0.04),
//                     Expanded(
//                       child: _buildInputField(
//                           "Security Code", Icons.lock, TextInputType.number),
//                     ),
//                   ],
//                 ),
//                 _buildInputField(
//                     "Postal Code", Icons.location_pin, TextInputType.number),
//                 _buildInputField("Nick Name", Icons.person, TextInputType.text),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildInputField(
//       String label, IconData icon, TextInputType keyboardType) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
//           ),
//           const SizedBox(height: 5),
//           Card(
//             elevation: 2,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: TextField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(
//                   icon,
//                 ),
//                 hintText: "Enter $label",
//                 border: InputBorder.none,
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//               ),
//               keyboardType: keyboardType,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddCardButton(double height, double width) {
//     return GestureDetector(
//       onTap: () => Navigator.pop(context),
//       child: TweenAnimationBuilder(
//         tween: Tween<double>(begin: 1.0, end: 1.1),
//         duration: const Duration(milliseconds: 300),
//         builder: (context, double scale, child) {
//           return Transform.scale(
//             scale: scale,
//             child: Container(
//               height: height * 0.05,
//               width: width * 0.3,
//               decoration: BoxDecoration(
//                 color: Colors.pink[200],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Center(
//                 child: Text(
//                   "Add Card",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentMethodScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaveCard;

  const PaymentMethodScreen({super.key, required this.onSaveCard});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _securityCodeController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _nickNameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _securityCodeController.dispose();
    _postalCodeController.dispose();
    _nickNameController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      final card = {
        'name': _nameController.text,
        'cardNumber': _cardNumberController.text,
        'expiryDate': _expiryDateController.text,
        'securityCode': _securityCodeController.text,
        'postalCode': _postalCodeController.text,
        'nickName': _nickNameController.text,
        'type': _getCardType(_cardNumberController.text),
      };

      widget.onSaveCard(card);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Card added successfully");
    }
  }

  String _getCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) return 'Visa';
    if (cardNumber.startsWith('5')) return 'MasterCard';
    if (cardNumber.startsWith('3')) return 'American Express';
    return 'Credit Card';
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    _buildAppBar(width, context),
                    SizedBox(height: height * 0.08),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildCardForm(height, width),
                            SizedBox(height: height * 0.02),
                            _buildAddCardButton(height, width),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
          "Add Card",
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
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInputField(
                  "Name on Card",
                  Icons.credit_card,
                  TextInputType.name,
                  _nameController,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name on card';
                    }
                    return null;
                  },
                ),
                _buildInputField(
                  "Card Number",
                  Icons.dialpad,
                  TextInputType.number,
                  _cardNumberController,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card number';
                    }
                    if (value.length < 16) {
                      return 'Enter valid card number';
                    }
                    return null;
                  },
                  maxLength: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        "Expiry Date",
                        Icons.calendar_today,
                        TextInputType.datetime,
                        _expiryDateController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter expiry date';
                          }
                          if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$')
                              .hasMatch(value)) {
                            return 'Enter valid MM/YY';
                          }
                          return null;
                        },
                        hintText: 'MM/YY',
                        maxLength: 5,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: _buildInputField(
                        "Security Code",
                        Icons.lock,
                        TextInputType.number,
                        _securityCodeController,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter CVV';
                          }
                          if (value.length < 3) {
                            return 'Enter valid CVV';
                          }
                          return null;
                        },
                        maxLength: 4,
                      ),
                    ),
                  ],
                ),
                _buildInputField(
                  "Postal Code",
                  Icons.location_pin,
                  TextInputType.number,
                  _postalCodeController,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  },
                ),
                _buildInputField(
                  "Nick Name",
                  Icons.person,
                  TextInputType.text,
                  _nickNameController,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a nickname';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(
    String label,
    IconData icon,
    TextInputType keyboardType,
    TextEditingController controller,
    FormFieldValidator<String> validator, {
    String? hintText,
    int? maxLength,
  }) {
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
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                hintText: hintText ?? "Enter $label",
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                counterText: '',
              ),
              keyboardType: keyboardType,
              validator: validator,
              maxLength: maxLength,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton(double height, double width) {
    return GestureDetector(
      onTap: _saveCard,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: 1.1),
        duration: const Duration(milliseconds: 300),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              height: height * 0.05,
              width: width * 0.5,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Add Card",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
