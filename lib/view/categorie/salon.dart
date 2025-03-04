import 'package:beautybazzle/controller/editprofilecontroller.dart';
import 'package:beautybazzle/model/addoffer.dart';
import 'package:beautybazzle/model/addservices.dart';
import 'package:beautybazzle/model/addspecialist.dart';
import 'package:beautybazzle/model/addwork.dart';
import 'package:beautybazzle/model/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/appoinment/appointment_book.dart';
import 'package:beautybazzle/view/profiles/profile.dart';
import 'package:beautybazzle/view/setting/showschedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
    return GetBuilder<ProfileController>(builder: (obj) {
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
                                image: obj.usermodel!.SalonPicture != ""
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            StaticData.userModel!.SalonPicture),
                                      )
                                    : null,
                              ),
                              child: obj.usermodel!.SalonPicture == ""
                                  ? CircleAvatar(
                                      radius: 100,
                                      backgroundColor: Colors.pink[200],
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    )
                                  : null,
                            ),
                          )

                          // Center(
                          //     child:
                          //      Container(
                          //   decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image:  )),
                          // )),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 350, top: 40),
                          //   child: GestureDetector(
                          //     onTap: toggleFavorite,
                          //     child: CircleAvatar(
                          //         backgroundColor: Colors.white,
                          //         radius: 18,
                          //         child: Center(AssetImage("images/salon.jpeg")
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: height * 0.03,
                                    width: width * 0.25,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                    "${obj.usermodel!.SalonName}",
                                    style: TextStyle(
                                        fontSize: width * 0.06,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      obj.usermodel == null ||
                                              obj.usermodel!.Address == ""
                                          ? const SizedBox()
                                          : Container(
                                              height: height * 0.035,
                                              width: width * 0.9,
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.location_on),
                                                  SizedBox(
                                                    width: width * 0.02,
                                                  ),
                                                  Text(
                                                    "${obj.usermodel!.Address}",
                                                    style: TextStyle(
                                                        fontSize: width * 0.04),
                                                  )
                                                ],
                                              ),
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
                                height: height * 0.09,
                                width: width * 0.95,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundImage:
                                        obj.usermodel!.ProfilePicture != ""
                                            ? NetworkImage(
                                                obj.usermodel!.ProfilePicture)
                                            : null,
                                    backgroundColor: Colors.pink[200],
                                    child: obj.usermodel!.ProfilePicture == ""
                                        ? const Icon(
                                            Icons.camera_alt,
                                            size: 25,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  title: Text(
                                    "${obj.usermodel!.name}",
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
                                            builder: (context) =>
                                                ProfileScreen(),
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
                                        style: TextStyle(
                                            fontSize: width * 0.03,
                                            color: Colors.white),
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
                                              InkWell(
                                                onTap: () =>
                                                    obj.showScheduleDialog(
                                                        context),
                                                child: Container(
                                                  child: Text(
                                                    "View Schedule",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: width * 0.03,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            obj.usermodel == null ||
                                    obj.usermodel!.salonDescription == ""
                                ? const SizedBox()
                                : Container(
                                    child: ListTile(
                                      title: Text(
                                        "Description",
                                        style: TextStyle(
                                            fontSize: width * 0.045,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        "${obj.usermodel!.salonDescription}",
                                        style: TextStyle(
                                            fontSize: width * 0.036,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.fade),
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
                                  Tab(text: "Offers"),
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
                                  Container(
                                    // height: height * 0.15,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('services')
                                          .where("userId",
                                              isEqualTo:
                                                  StaticData.userModel!.UserId)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        }
                                        if (!snapshot.hasData ||
                                            snapshot.data!.docs.isEmpty) {
                                          return const Center(
                                              child: Text(
                                                  'No services available'));
                                        }

                                        final width =
                                            MediaQuery.of(context).size.width;

                                        return Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                snapshot.data!.docs.map((doc) {
                                              ServiceModel model =
                                                  ServiceModel.fromMap(doc
                                                          .data()
                                                      as Map<String, dynamic>);

                                              return TweenAnimationBuilder(
                                                tween: Tween<double>(
                                                    begin: 0.0, end: 1.0),
                                                duration: const Duration(
                                                    milliseconds: 800),
                                                curve: Curves.easeOut,
                                                builder: (context, double value,
                                                    child) {
                                                  return Opacity(
                                                    opacity: value,
                                                    child: Transform.translate(
                                                      offset: Offset(
                                                          0, 50 * (1 - value)),
                                                      child: child,
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  child: Container(
                                                    height: height * 0.1,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black12,
                                                          width: width * 0.002),
                                                    ),
                                                    child: Center(
                                                      child: ListTile(
                                                        leading: Container(
                                                          height: height * 0.07,
                                                          width: width * 0.15,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  model.servicePic ??
                                                                      ''), // Safe access
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        title: Text(
                                                          model.serviceName ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize:
                                                                width * 0.04,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          model.serviceDescription ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize:
                                                                width * 0.028,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Expanded(
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('specialists')
                                              .where("userId",
                                                  isEqualTo: StaticData
                                                      .userModel!.UserId)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child: Text(
                                                      'No Specialists available'));
                                            }

                                            final width = MediaQuery.of(context)
                                                .size
                                                .width;
                                            final height =
                                                MediaQuery.of(context)
                                                    .size
                                                    .height;

                                            // Convert Firestore docs to SpecialistModel list
                                            List<SpecialistModel> specialists =
                                                snapshot.data!.docs.map((doc) {
                                              return SpecialistModel.fromMap(
                                                  doc.data()
                                                      as Map<String, dynamic>);
                                            }).toList();

                                            return GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    2, // number of items in each row
                                                mainAxisSpacing:
                                                    8.0, // spacing between rows
                                                crossAxisSpacing:
                                                    8.0, // spacing between columns
                                              ),
                                              padding: const EdgeInsets.all(
                                                  8.0), // padding around the grid
                                              itemCount: specialists
                                                  .length, // total number of items
                                              itemBuilder: (context, index) {
                                                SpecialistModel pair =
                                                    specialists[index];
                                                return TweenAnimationBuilder(
                                                  tween: Tween<double>(
                                                      begin: 0.0, end: 1.0),
                                                  duration: const Duration(
                                                      milliseconds: 800),
                                                  curve: Curves.easeOut,
                                                  builder: (context,
                                                      double value, child) {
                                                    return Opacity(
                                                      opacity: value,
                                                      child:
                                                          Transform.translate(
                                                        offset: Offset(0,
                                                            50 * (1 - value)),
                                                        child: child,
                                                      ),
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Card(
                                                          elevation: 2,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Container(
                                                            height:
                                                                height * 0.23,
                                                            width: width * 0.43,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.01,
                                                                ),
                                                                CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          pair.specialistPic ??
                                                                              ''),
                                                                ),
                                                                Container(
                                                                  height:
                                                                      height *
                                                                          0.08,
                                                                  width: width,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          pair.specialistName ??
                                                                              '',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                width * 0.032,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            overflow:
                                                                                TextOverflow.clip,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          pair.specialistServiceName ??
                                                                              '',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                width * 0.032,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            overflow:
                                                                                TextOverflow.fade,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            RatingStars(
                                                                              value: rating,
                                                                              onValueChanged: (newRating) {},
                                                                              starCount: 5,
                                                                              starSize: 12,
                                                                              starColor: const Color.fromARGB(255, 241, 134, 170),
                                                                              valueLabelColor: const Color.fromRGBO(240, 134, 169, 1),
                                                                              starSpacing: 2,
                                                                              valueLabelVisibility: false,
                                                                            ),
                                                                            SizedBox(width: width * 0.03),
                                                                            Text(
                                                                              '$rating',
                                                                              style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('offers')
                                          .where("userId",
                                              isEqualTo: StaticData
                                                      .userModel?.UserId ??
                                                  '')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        }
                                        if (!snapshot.hasData ||
                                            snapshot.data!.docs.isEmpty) {
                                          return const Center(
                                              child:
                                                  Text('No offers available'));
                                        }

                                        final width =
                                            MediaQuery.of(context).size.width;
                                        final height =
                                            MediaQuery.of(context).size.height;

                                        // Convert Firestore docs to OfferModel list
                                        List<OfferModel> offers =
                                            snapshot.data!.docs.map((doc) {
                                          return OfferModel.fromMap(doc.data()
                                              as Map<String, dynamic>);
                                        }).toList();

                                        return GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                2, // number of items in each row
                                            mainAxisSpacing:
                                                8.0, // spacing between rows
                                            crossAxisSpacing:
                                                8.0, // spacing between columns
                                          ),
                                          padding: const EdgeInsets.all(
                                              8.0), // padding around the grid
                                          itemCount: offers
                                              .length, // total number of items
                                          itemBuilder: (context, index) {
                                            OfferModel pair = offers[index];
                                            return TweenAnimationBuilder(
                                              tween: Tween<double>(
                                                  begin: 0.0, end: 1.0),
                                              duration: const Duration(
                                                  milliseconds: 800),
                                              curve: Curves.easeOut,
                                              builder: (context, double value,
                                                  child) {
                                                return Opacity(
                                                  opacity: value,
                                                  child: Transform.translate(
                                                    offset: Offset(
                                                        0, 50 * (1 - value)),
                                                    child: child,
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 8,
                                                            top: 10,
                                                            bottom: 10),
                                                    child: Container(
                                                      width: width * 0.4,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black45),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              pair.offerPic),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(height: height * 0.02),

                                        TweenAnimationBuilder(
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 5),
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
                                          tween: Tween<double>(
                                              begin: 0.0, end: 1.0),
                                          duration:
                                              Duration(milliseconds: 1000),
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
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('recentworks')
                                                      .where("userId",
                                                          isEqualTo: StaticData
                                                              .userModel!
                                                              .UserId)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }

                                                    if (snapshot.hasError) {
                                                      return Center(
                                                          child: Text(
                                                              'Error: ${snapshot.error}'));
                                                    }

                                                    if (!snapshot.hasData ||
                                                        snapshot.data!.docs
                                                            .isEmpty) {
                                                      return const Center(
                                                          child: Text(
                                                              'No Work available'));
                                                    }

                                                    final width =
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width;
                                                    final height =
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height;

                                                    return Container(
                                                      height: height * 0.15,
                                                      width: width,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: snapshot
                                                            .data!.docs.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          Map<String, dynamic>
                                                              docData = snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>;

                                                          RecentWorkModel
                                                              model =
                                                              RecentWorkModel
                                                                  .fromMap(
                                                                      docData);

                                                          String recentWorkPic =
                                                              model.RecentworkPic ??
                                                                  '';
                                                          String recentWorkId =
                                                              model.RecentworkId ??
                                                                  '';

                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  width: width *
                                                                      0.3,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border
                                                                        .all(),
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          recentWorkPic),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
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
                                          tween: Tween<double>(
                                              begin: 0.0, end: 1.0),
                                          duration:
                                              Duration(milliseconds: 1200),
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 15.0,
                                                              right: 10),
                                                      child: Container(
                                                        height: height * 0.2,
                                                        width: width * 0.92,
                                                        decoration:
                                                            BoxDecoration(
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
                                            duration:
                                                Duration(milliseconds: 800),
                                            curve: Curves.easeOut,
                                            builder:
                                                (context, double value, child) {
                                              return Opacity(
                                                opacity: value,
                                                child: Transform.translate(
                                                  offset: Offset(
                                                      0, (1 - value) * 50),
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      overflow:
                                                          TextOverflow.fade,
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
                                                      valueLabelVisibility:
                                                          true,
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
                      border: Border.all(
                          color: Colors.black12, width: width * 0.005),
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
                              color: Colors.white,
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
    });
  }
}
