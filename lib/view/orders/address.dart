// import 'package:flutter/material.dart';

// class NewAddressScreen extends StatefulWidget {
//   const NewAddressScreen({super.key});

//   @override
//   State<NewAddressScreen> createState() => _NewAddressScreenState();
// }

// class _NewAddressScreenState extends State<NewAddressScreen> {
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
//           "Add Address",
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
//                 _buildInputField("Name ", Icons.person, TextInputType.name),
//                 _buildInputField(
//                     "Address Lane", Icons.location_pin, TextInputType.number),
//                 _buildInputField(
//                     "City", Icons.location_pin, TextInputType.number),
//                 _buildInputField(
//                     "Postal Code", Icons.password, TextInputType.number),
//                 _buildInputField(
//                     "Phone Number", Icons.phone, TextInputType.text),
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
//                   "Add Address",
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

class NewAddressScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaveAddress;

  const NewAddressScreen({super.key, required this.onSaveAddress});

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  String _addressType = 'Home';

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = {
        'name': _nameController.text,
        'address': _addressController.text,
        'city': _cityController.text,
        'postalCode': _postalCodeController.text,
        'phone': _phoneController.text,
        'type': _addressType,
      };

      widget.onSaveAddress(address);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                  "Add New Address",
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
          SingleChildScrollView(
            padding: EdgeInsets.all(width * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildAddressTypeSelector(width),
                  SizedBox(height: height * 0.03),
                  _buildInputField("Full Name", Icons.person,
                      TextInputType.name, _nameController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  }),
                  _buildInputField("Full Address", Icons.location_on,
                      TextInputType.streetAddress, _addressController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  }),
                  _buildInputField("City", Icons.location_city,
                      TextInputType.text, _cityController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  }),
                  _buildInputField("Postal Code", Icons.markunread_mailbox,
                      TextInputType.number, _postalCodeController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  }),
                  _buildInputField("Phone Number", Icons.phone,
                      TextInputType.phone, _phoneController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (value.length < 10) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  }),
                  SizedBox(height: height * 0.05),
                  _buildSaveButton(width),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTypeSelector(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTypeButton('Home', Icons.home, width),
        _buildTypeButton('Work', Icons.work, width),
        _buildTypeButton('Other', Icons.location_city, width),
      ],
    );
  }

  Widget _buildTypeButton(String type, IconData icon, double width) {
    return GestureDetector(
      onTap: () => setState(() => _addressType = type),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 10),
        decoration: BoxDecoration(
          color: _addressType == type ? Colors.pink[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: width * 0.05),
            SizedBox(width: width * 0.02),
            Text(type),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    IconData icon,
    TextInputType keyboardType,
    TextEditingController controller,
    FormFieldValidator<String> validator,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
            keyboardType: keyboardType,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(double width) {
    return SizedBox(
      width: width * 0.9,
      child: ElevatedButton(
        onPressed: _saveAddress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[200],
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          'SAVE ADDRESS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
