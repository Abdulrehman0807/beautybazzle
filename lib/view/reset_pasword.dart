// import 'package:beautybazzle/utiils/static_data.dart';
// import 'package:beautybazzle/view/enter_otp.dart';
// import 'package:flutter/material.dart';

// class ResetPaswordScreen extends StatefulWidget {
//   const ResetPaswordScreen({super.key});

//   @override
//   State<ResetPaswordScreen> createState() => _ResetPaswordScreenState();
// }

// class _ResetPaswordScreenState extends State<ResetPaswordScreen> {
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         body: Container(
//             height: height,
//             width: width,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage("images/background3.jpg"))),
//             child: Column(children: [
//               SizedBox(
//                 height: height * 0.15,
//               ),
//               Container(
//                 height: height * 0.25,
//                 width: width * 0.7,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(StaticData.myLogo))),
//               ),
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               SizedBox(
//                 height: height * 0.06,
//                 width: width * 0.85,
//                 child: Text("Forget Password",
//                     style: TextStyle(
//                         fontSize: width * 0.07, fontWeight: FontWeight.w500)),
//               ),
//               Container(
//                 height: height * 0.06,
//                 width: width * 0.85,
//                 child: Text(
//                     "Won't worry! Its happens, please enter the email address associated with your account",
//                     style: TextStyle(
//                         fontSize: width * 0.035, fontWeight: FontWeight.w400)),
//               ),
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Container(
//                   height: height * 0.055,
//                   width: width * 0.85,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         prefixIcon: const Icon(
//                           Icons.email,
//                         ),
//                         filled: true,
//                         hintText: "Enter Email Address"),
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 elevation: 3,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OtpScreen(),
//                         ));
//                   },
//                   child: Container(
//                     height: height * 0.055,
//                     width: width * 0.85,
//                     decoration: BoxDecoration(
//                       color: Colors.pink[200],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(
//                       child: Text("Send Code",
//                           style: TextStyle(
//                               fontSize: width * 0.05,
//                               fontWeight: FontWeight.w500)),
//                     ),
//                   ),
//                 ),
//               ),
//             ])));
//   }
// }
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/enter_otp.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(StaticData.mybackground),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.15),

            // Logo with Fade-in and Scale Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: value,
                    child: Container(
                      height: height * 0.25,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(StaticData.myLogo),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // "Forget Password" Title with Slide Animation
            TweenAnimationBuilder(
              tween: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: Container(
                    width: width * 0.83,
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // Description Text with Fade Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.85,
                    child: Text(
                      "Don’t worry! This happens. Please enter the email address associated with your account.",
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // Email Text Field with Slide Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                    scale: scale,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: height * 0.055,
                        width: width * 0.85,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            hintText: "Enter Email Address",
                          ),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ));
              },
            ),

            SizedBox(height: height * 0.02),

            // "Send Code" Button with Scale Animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: height * 0.055,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.pink[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Send Code",
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
