import 'package:beautybazzle/model/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';

import 'package:beautybazzle/view/beauty_product.dart';
import 'package:beautybazzle/view/bottom_Nav_bar.dart';
import 'package:beautybazzle/view/editProfile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
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
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    // Row(
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => BottomNavBar(),
                    //             ));
                    //       },
                    //       child: CircleAvatar(
                    //         radius: 18,
                    //         backgroundColor: Colors.white,
                    //         child: const Icon(Icons.arrow_back,
                    //             color: Colors.black),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: width * 0.25,
                    //     ),
                    //     Text(
                    //       "${StaticData.userModel!.name}",
                    //       style: TextStyle(
                    //         fontSize: width * 0.05,
                    //         fontWeight: FontWeight.w600,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Container(
                      height: height * 0.13,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          CircleAvatar(
                            radius: 50,
                            foregroundColor: Colors.black,
                            backgroundImage: AssetImage(
                                StaticData.userModel!.ProfilePicture),
                          ),
                        ],
                      ),
                    ),
                    SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: height * 0.04,
                              width: width * 0.95,
                              child: Text(
                                "${StaticData.userModel!.name}",
                                style: TextStyle(
                                    fontSize: width * 0.06,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.035,
                            width: width * 0.95,
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                Text(
                                  "${StaticData.userModel!.Address}",
                                  style: TextStyle(fontSize: width * 0.04),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.035,
                            width: width,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: width * 0.04,
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Text("${StaticData.userModel!.YouTube}",
                                    style: TextStyle(
                                        fontSize: width * 0.027,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.035,
                            width: width,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebook,
                                    size: width * 0.04,
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Text(
                                  "${StaticData.userModel!.Facebook}",
                                  style: TextStyle(
                                      fontSize: width * 0.027,
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.035,
                            width: width,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.instagram,
                                    size: width * 0.04,
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: width * 0.015,
                                ),
                                Text("${StaticData.userModel!.Instagram}",
                                    style: TextStyle(
                                        fontSize: width * 0.027,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.035,
                            width: width,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.tiktok,
                                    size: width * 0.04,
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: width * 0.015,
                                ),
                                Text("${StaticData.userModel!.TikTok}",
                                    style: TextStyle(
                                        fontSize: width * 0.027,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.15,
                            width: width,
                            child: ListTile(
                              title: Text(
                                "About Me",
                                style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "${StaticData.userModel!.AboutMe}",
                                style: TextStyle(
                                  fontSize: width * 0.036,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.09,
                            width: width * 0.92,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    AssetImage("images/salon.jpeg"),
                              ),
                              title: Text(
                                "${StaticData.userModel!.SalonName}",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "${StaticData.userModel!.Address}",
                                style: TextStyle(
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen(),
                                        ));
                                  },
                                  child: Container(
                                    height: height * 0.04,
                                    width: width * 0.8,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: width * 0.05,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              height: height * 0.12,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 5,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          radius: 27,
                                          backgroundImage:
                                              AssetImage(StaticData.myDp),
                                        ),
                                        Text(
                                          "Hightlights",
                                          style: TextStyle(
                                            fontSize: width * 0.025,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            height: height * 0.035,
                            width: width * 0.93,
                            child: Text(
                              "Best Offers",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 1000),
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
                            child: Container(
                              height: height * 0.15,
                              width: width,
                              child: ListView.builder(
                                itemCount: 2,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      width: width * 0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "images/offer.jpeg")),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.05,
                      width: width,
                      child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black54,
                        isScrollable: false,
                        tabs: [
                          Tab(text: "Services"),
                          Tab(text: "Specialist"),
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
                        height: UserModel1.mylist.length * height * 0.16,
                        width: width,
                        child: TabBarView(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: UserModel1.mylist.map((item) {
                              return TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 800),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
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
                                                  image:
                                                      AssetImage(item.image!)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        title: Text(
                                          item.name!,
                                          style: TextStyle(
                                              fontSize: width * 0.04,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                          item.Description!,
                                          style: TextStyle(
                                              fontSize: width * 0.028,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.fade),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: UserModel2.mylist.map((item) {
                                  return TweenAnimationBuilder(
                                    tween: Tween<double>(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 800),
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
                                          vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Container(
                                              height: height * 0.2,
                                              width: width * 0.43,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage:
                                                        AssetImage(item.image!),
                                                  ),
                                                  Container(
                                                    height: height * 0.08,
                                                    width: width,
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
                                                              style: TextStyle(
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
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.032,
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
                                                                value: rating,
                                                                onValueChanged:
                                                                    (newRating) {},
                                                                starCount:
                                                                    5, // Number of stars
                                                                starSize:
                                                                    12, // Size of the stars
                                                                starColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        241,
                                                                        134,
                                                                        170),
                                                                valueLabelColor:
                                                                    Color
                                                                        .fromRGBO(
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
                                                                  fontSize: 14,
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
                                                    BorderRadius.circular(10)),
                                            child: Container(
                                              height: height * 0.2,
                                              width: width * 0.43,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage(
                                                        StaticData.myDp),
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
                                                              style: TextStyle(
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
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.032,
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
                                                                value: rating,
                                                                onValueChanged:
                                                                    (newRating) {},
                                                                starCount:
                                                                    5, // Number of stars
                                                                starSize:
                                                                    12, // Size of the stars
                                                                starColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        241,
                                                                        134,
                                                                        170),
                                                                valueLabelColor:
                                                                    Color
                                                                        .fromRGBO(
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
                                                                  fontSize: 14,
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
                          Column(
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),

                              Container(
                                height: height * 0.035,
                                width: width * 0.93,
                                child: Text(
                                  "Special Offer Products",
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: Duration(milliseconds: 1000),
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
                                child: Container(
                                  height: height * 0.15,
                                  width: width,
                                  child: ListView.builder(
                                    itemCount: 2,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BeautyProductScreen(),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            width: width * 0.3,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "images/product.jpg")),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: Duration(milliseconds: 800),
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
                                child: Container(
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
                              ),
                              TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: Duration(milliseconds: 1000),
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
                                child: Container(
                                  height: height * 0.15,
                                  width: width,
                                  child: ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          height: height * 0.1,
                                          width: width * 0.3,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  AssetImage("images/work.jpg"),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),

                              // Repeated animation structure for "Tips and Tricks"
                              TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: Duration(milliseconds: 800),
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
                                child: Container(
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
                              ),

                              TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: Duration(milliseconds: 1000),
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
                                child: Container(
                                  height: height * 0.25,
                                  child: ListView.builder(
                                    itemCount: 1,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 15.0, right: 10),
                                        child: Container(
                                          height: height * 0.22,
                                          width: width * 0.92,
                                          decoration: BoxDecoration(
                                            color: Colors.brown,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: UserModel1.mylist.map((item) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: TweenAnimationBuilder(
                                    tween: Tween<double>(begin: 0.0, end: 1.0),
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.easeOut,
                                    builder: (context, double value, child) {
                                      return Opacity(
                                        opacity: value,
                                        child: Transform.translate(
                                          offset: Offset(0, (1 - value) * 50),
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
                                            backgroundImage:
                                                AssetImage(StaticData.myDp),
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
                                              onValueChanged: (newRating) {},
                                              starCount: 5, // Number of stars
                                              starSize: 12, // Size of the stars
                                              starColor: Color.fromARGB(
                                                  255, 241, 134, 170),
                                              valueLabelColor: Color.fromRGBO(
                                                  240, 134, 169, 1),
                                              starSpacing:
                                                  2, // Space between the stars
                                              valueLabelVisibility: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
