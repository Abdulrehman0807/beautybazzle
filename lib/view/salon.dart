import 'package:beautybazzle/model/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/appointment_book.dart';
import 'package:beautybazzle/view/profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SalonScreen extends StatefulWidget {
  const SalonScreen({super.key});

  @override
  State<SalonScreen> createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen>
    with SingleTickerProviderStateMixin {
  double rating = 4.0;
  PageController controller = PageController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite; // Toggle favorite state
    });

    // Show toast message
    Fluttertoast.showToast(
      msg: isFavorite
          ? "Successfully added to favorites"
          : "Removed from favorites",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.pink[200],
      textColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Center(
                            child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/salon.jpeg"))),
                        )),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 350, top: 40),
                        //   child: GestureDetector(
                        //     onTap: toggleFavorite,
                        //     child: CircleAvatar(
                        //         backgroundColor: Colors.white,
                        //         radius: 18,
                        //         child: Center(
                        //           child: Icon(
                        //             isFavorite
                        //                 ? Icons.favorite
                        //                 : Icons.favorite_border,
                        //             color:
                        //                 isFavorite ? Colors.red : Colors.grey,
                        //             size: 25,
                        //           ),
                        //         )),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  floating: true,
                  pinned: false,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SlideTransition(
                        position: _slideAnimation,
                        child: Column(children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            height: height * 0.04,
                            width: width * 0.93,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height * 0.03,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Text(
                                      "Open Space",
                                      style: TextStyle(
                                          fontSize: width * 0.035,
                                          color: Colors.pink[200],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Row(children: [
                                  RatingStars(
                                    value: rating,
                                    onValueChanged: (newRating) {},
                                    starCount: 1, // Number of stars
                                    starSize: 16, // Size of the stars
                                    starColor:
                                        Color.fromARGB(255, 241, 134, 170),
                                    valueLabelColor:
                                        Color.fromRGBO(240, 134, 169, 1),
                                    starSpacing: 2, // Space between the stars
                                    valueLabelVisibility: false,
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  Text(
                                    '$rating',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors
                                          .black, // Adjust color as needed
                                    ),
                                  ),
                                  Text(
                                    '  (365 reviews)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors
                                          .black, // Adjust color as needed
                                    ),
                                  ),
                                ]))
                              ],
                            ),
                          ),
                          Container(
                              height: height * 0.1,
                              width: width,
                              child: ListTile(
                                title: Text(
                                  "Ajoba BeautyPalour",
                                  style: TextStyle(
                                      fontSize: width * 0.06,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 15,
                                        child: Icon(
                                          Icons.location_on,
                                          size: 19,
                                          color: Colors.black,
                                        )),
                                    Text(
                                      "Ghoeer town bahwalpur",
                                      style: TextStyle(
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                            height: height * 0.04,
                            width: width * 0.93,
                            child: Text(
                              "Operated by",
                              style: TextStyle(
                                  fontSize: width * 0.037,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: height * 0.085,
                              width: width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: AssetImage(StaticData.myDp),
                                ),
                                title: Text(
                                  "Alina Shahzad",
                                  style: TextStyle(
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  "Beauty Specialist",
                                  style: TextStyle(
                                      fontSize: width * 0.032,
                                      fontWeight: FontWeight.w400),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(),
                                        ));
                                  },
                                  child: Container(
                                    height: height * 0.04,
                                    width: width * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.pink[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "View Profile",
                                      style: TextStyle(fontSize: width * 0.03),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            height: height * 0.12,
                            child: ListTile(
                                title: Text(
                                  "About",
                                  style: TextStyle(
                                      fontSize: width * 0.05,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Container(
                                  height: height * 0.07,
                                  width: width * 0.93,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.3,
                                        height: height,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 15,
                                                child: Icon(
                                                  Icons.directions_walk,
                                                  color: Colors.black,
                                                )),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "05  ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.04,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              TextSpan(
                                                  text: "Mins",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.033,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ])),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.3,
                                        height: height,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 15,
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                )),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "2.3  ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.04,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              TextSpan(
                                                  text: "km",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.033,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ])),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.3,
                                        height: height,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 15,
                                                child: Icon(
                                                  Icons.access_time_filled,
                                                  color: Colors.black,
                                                )),
                                            Text(
                                              "Sun - Mon",
                                              style: TextStyle(
                                                  fontSize: width * 0.035,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          Container(
                            height: height * 0.14,
                            child: ListTile(
                              title: Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "Enhancing your natural beauty with personalized care and expertise at Ajoba Beauty Parlor.Step into a world of elegance and relaxation — Ajoba Beauty Parlor, where beauty meets excellence.",
                                style: TextStyle(
                                    fontSize: width * 0.036,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.05,
                            width: width,
                            child: TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black54,
                              isScrollable: true,
                              tabs: [
                                Tab(text: "Services"),
                                Tab(text: "Specialist"),
                                Tab(text: "Packages"),
                                Tab(
                                  text: "Gallery",
                                ),
                                Tab(
                                  text: "Reviews",
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: UserModel1.mylist.length * height * 0.15,
                            width: width,
                            child: TabBarView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: UserModel1.mylist.map((item) {
                                    return TweenAnimationBuilder(
                                      tween:
                                          Tween<double>(begin: 0.0, end: 1.0),
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOut,
                                      builder: (context, double value, child) {
                                        return Opacity(
                                          opacity: value,
                                          child: Transform.translate(
                                            offset: Offset(0, 50 * (1 - value)),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Container(
                                          height: height * 0.12,
                                          width: width,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: width * 0.002)),
                                          child: Center(
                                            child: ListTile(
                                              leading: Container(
                                                height: height * 0.07,
                                                width: width * 0.15,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            item.image!)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              title: Text(
                                                item.name!,
                                                style: TextStyle(
                                                    fontSize: width * 0.04,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Text(
                                                item.Description!,
                                                style: TextStyle(
                                                    fontSize: width * 0.028,
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                        TextOverflow.fade),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Container(
                                      height: height * 0.035,
                                      width: width * 0.9,
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Specialist  ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w600)),
                                        TextSpan(
                                            text: "(18)",
                                            style: TextStyle(
                                                color: Colors.pink[200],
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: UserModel2.mylist.map((item) {
                                        return TweenAnimationBuilder(
                                          tween: Tween<double>(
                                              begin: 0.0, end: 1.0),
                                          duration:
                                              const Duration(milliseconds: 800),
                                          curve: Curves.easeOut,
                                          builder:
                                              (context, double value, child) {
                                            return Opacity(
                                              opacity: value,
                                              child: Transform.translate(
                                                offset:
                                                    Offset(0, 50 * (1 - value)),
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Container(
                                                    height: height * 0.2,
                                                    width: width * 0.43,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  item.image!),
                                                        ),
                                                        Container(
                                                          height: height * 0.08,
                                                          width: width * 0.3,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Center(
                                                                  child: Text(
                                                                    "Alena Shahzad",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.032,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  item.name!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.032,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                    RatingStars(
                                                                      value:
                                                                          rating,
                                                                      onValueChanged:
                                                                          (newRating) {},
                                                                      starCount:
                                                                          5, // Number of stars
                                                                      starSize:
                                                                          12, // Size of the stars
                                                                      starColor: Color.fromARGB(
                                                                          255,
                                                                          241,
                                                                          134,
                                                                          170),
                                                                      valueLabelColor: Color.fromRGBO(
                                                                          240,
                                                                          134,
                                                                          169,
                                                                          1),
                                                                      starSpacing:
                                                                          2, // Space between the stars
                                                                      valueLabelVisibility:
                                                                          false,
                                                                    ),
                                                                    SizedBox(
                                                                      width: width *
                                                                          0.03,
                                                                    ),
                                                                    Text(
                                                                      '$rating',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black, // Adjust color as needed
                                                                      ),
                                                                    ),
                                                                  ]))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Container(
                                                    height: height * 0.2,
                                                    width: width * 0.43,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  StaticData
                                                                      .myDp),
                                                        ),
                                                        Container(
                                                          height: height * 0.08,
                                                          width: width * 0.3,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Center(
                                                                  child: Text(
                                                                    "Alena Shahzad",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.032,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  item.name!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.032,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                    RatingStars(
                                                                      value:
                                                                          rating,
                                                                      onValueChanged:
                                                                          (newRating) {},
                                                                      starCount:
                                                                          5, // Number of stars
                                                                      starSize:
                                                                          12, // Size of the stars
                                                                      starColor: Color.fromARGB(
                                                                          255,
                                                                          241,
                                                                          134,
                                                                          170),
                                                                      valueLabelColor: Color.fromRGBO(
                                                                          240,
                                                                          134,
                                                                          169,
                                                                          1),
                                                                      starSpacing:
                                                                          2, // Space between the stars
                                                                      valueLabelVisibility:
                                                                          false,
                                                                    ),
                                                                    SizedBox(
                                                                      width: width *
                                                                          0.03,
                                                                    ),
                                                                    Text(
                                                                      '$rating',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black, // Adjust color as needed
                                                                      ),
                                                                    ),
                                                                  ]))
                                                            ],
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
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: UserModel3.mylist.map((item) {
                                      return TweenAnimationBuilder(
                                        duration: Duration(milliseconds: 500),
                                        tween: Tween(
                                            begin: 0.8,
                                            end: 1.0), // Fade-in and scale
                                        curve: Curves.easeOut,
                                        builder:
                                            (context, double value, child) {
                                          return Opacity(
                                            opacity: value, // Adjust opacity
                                            child: Transform.scale(
                                              scale: value, // Adjust scale
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Container(
                                                    height: height * 0.2,
                                                    width: width * 0.37,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              item.image!)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  height: height * 0.2,
                                                  width: width * 0.37,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            item.image!)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(height: height * 0.02),

                                      // Animated Highlights Section
                                      TweenAnimationBuilder(
                                        tween:
                                            Tween<double>(begin: 0.0, end: 1.0),
                                        duration: Duration(milliseconds: 800),
                                        curve: Curves.easeOut,
                                        builder:
                                            (context, double value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset:
                                                  Offset(0, 50 * (1 - value)),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height * 0.03,
                                              width: width * 0.93,
                                              child: Text(
                                                "Highlights",
                                                style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: height * 0.1,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 3,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 35,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "images/girl.jpg"),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Animated Recent Work Section
                                      TweenAnimationBuilder(
                                        tween:
                                            Tween<double>(begin: 0.0, end: 1.0),
                                        duration: Duration(milliseconds: 1000),
                                        curve: Curves.easeOut,
                                        builder:
                                            (context, double value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset:
                                                  Offset(0, 50 * (1 - value)),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height * 0.035,
                                              width: width * 0.93,
                                              child: Text(
                                                "Recent Work",
                                                style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: height * 0.15,
                                              width: width,
                                              child: ListView.builder(
                                                itemCount: 5,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Container(
                                                      height: height * 0.0,
                                                      width: width * 0.3,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                "images/work.jpg")),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Animated Tips and Tricks Section
                                      TweenAnimationBuilder(
                                        tween:
                                            Tween<double>(begin: 0.0, end: 1.0),
                                        duration: Duration(milliseconds: 1200),
                                        curve: Curves.easeOut,
                                        builder:
                                            (context, double value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset:
                                                  Offset(0, 50 * (1 - value)),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height * 0.03,
                                              width: width * 0.93,
                                              child: Text(
                                                "Tips and Tricks",
                                                style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: height * 0.27,
                                              child: ListView.builder(
                                                itemCount: 1,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            left: 15.0,
                                                            right: 10),
                                                    child: Container(
                                                      height: height * 0.2,
                                                      width: width * 0.92,
                                                      decoration: BoxDecoration(
                                                        color: Colors.brown,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: UserModel1.mylist.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: TweenAnimationBuilder(
                                          tween: Tween<double>(
                                              begin: 0.0, end: 1.0),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.easeOut,
                                          builder:
                                              (context, double value, child) {
                                            return Opacity(
                                              opacity: value,
                                              child: Transform.translate(
                                                offset:
                                                    Offset(0, (1 - value) * 50),
                                                child: child,
                                              ),
                                            );
                                          },
                                          child: Card(
                                            elevation: 2,
                                            child: Container(
                                              height: height * 0.1,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: AssetImage(
                                                      StaticData.myDp),
                                                ),
                                                title: Text(
                                                  "The makeup session was flawless and lasted the entire event without a touch-up. So professional!",
                                                  style: TextStyle(
                                                    fontSize: width * 0.032,
                                                    fontWeight: FontWeight.w400,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                                subtitle: Container(
                                                  height: height * 0.03,
                                                  child: RatingStars(
                                                    value: rating,
                                                    onValueChanged:
                                                        (newRating) {},
                                                    starCount:
                                                        5, // Number of stars
                                                    starSize:
                                                        12, // Size of the stars
                                                    starColor: Color.fromARGB(
                                                        255, 241, 134, 170),
                                                    valueLabelColor:
                                                        Color.fromRGBO(
                                                            240, 134, 169, 1),
                                                    starSpacing:
                                                        2, // Space between the stars
                                                    valueLabelVisibility: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
                        topLeft: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.07,
                      width: width * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Price",
                            style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "\$6.00  ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: "/hr",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width * 0.03,
                                    fontWeight: FontWeight.w400))
                          ])),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentBookScreen(),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 252, 128, 169),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
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
