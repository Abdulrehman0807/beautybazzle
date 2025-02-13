import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/profiles/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class SpecialistsScreen extends StatefulWidget {
  const SpecialistsScreen({super.key});

  @override
  State<SpecialistsScreen> createState() => _SpecialistsScreenState();
}

class _SpecialistsScreenState extends State<SpecialistsScreen> {
  var rating = 4.0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(height: height * 0.05),
            Row(
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
                  "Beauty Specialists",
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
            SizedBox(height: height * 0.02),
            Container(
              height: height * 0.04,
              width: width * 0.93,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Specialists ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "(120)",
                      style: TextStyle(
                        color: Colors.pink[200],
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder(
                      duration: Duration(milliseconds: 500),
                      tween: Tween(begin: 0.0, end: 1.0), // Fade-in and scale
                      curve: Curves.easeOut,
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value, // Adjust opacity
                          child: Transform.scale(
                            scale: value, // Adjust scale
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildServiceCard(
                              height: height,
                              width: width,
                              title: "Alena Shahzad",
                              specialization: "Hair",
                              rating: rating,
                            ),
                            _buildServiceCard(
                              height: height,
                              width: width,
                              title: "Alena Shahzad",
                              specialization: "Makeup",
                              rating: rating,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required double height,
    required double width,
    required String title,
    required String specialization,
    required double rating,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ));
        },
        child: Container(
          height: height * 0.25,
          width: width * 0.40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(StaticData.myDp),
              ),
              Container(
                height: height * 0.11,
                width: width * 0.34,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: width * 0.032,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingStars(
                          value: rating,
                          onValueChanged: (newRating) {},
                          starCount: 5,
                          starSize: 12,
                          starColor: Color.fromARGB(255, 241, 134, 170),
                          valueLabelColor: Color.fromRGBO(240, 134, 169, 1),
                          starSpacing: 2,
                          valueLabelVisibility: false,
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          '$rating',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "$specialization ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "(Specialist)",
                              style: TextStyle(
                                color: Colors.pink[200],
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
