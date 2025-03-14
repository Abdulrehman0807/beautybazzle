import 'package:beautybazzle/controller/profile/editprofilecontroller.dart';
import 'package:beautybazzle/model/addoffer/addoffer.dart';
import 'package:beautybazzle/model/addproduct/addproduct.dart';
import 'package:beautybazzle/model/addservice/addservices.dart';
import 'package:beautybazzle/model/addspecialist/addspecialist.dart';
import 'package:beautybazzle/model/addwork/addwork.dart';
import 'package:beautybazzle/model/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/appoinment/appointment_book.dart';
import 'package:beautybazzle/view/bottom_bar/bottom_Nav_bar.dart';
import 'package:beautybazzle/view/categorie/beauty_product.dart';
import 'package:beautybazzle/view/categorie/salon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<ProfileController>(builder: (obj) {
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
                              backgroundImage: obj.usermodel!.ProfilePicture !=
                                      ""
                                  ? NetworkImage(obj.usermodel!.ProfilePicture)
                                  : null,
                              backgroundColor: Colors.pink[200],
                              child: obj.usermodel!.ProfilePicture == ""
                                  ? const Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  : null,
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
                            StaticData.userModel!.Address == ""
                                ? SizedBox()
                                : Container(
                                    height: height * 0.035,
                                    width: width * 0.95,
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        Text(
                                          "${StaticData.userModel!.Address}",
                                          style:
                                              TextStyle(fontSize: width * 0.04),
                                        )
                                      ],
                                    ),
                                  ),
                            StaticData.userModel!.YouTube == ""
                                ? SizedBox()
                                : Container(
                                    height: height * 0.035,
                                    width: width,
                                    child: Row(
                                      children: [
                                        // Icon(Icons.link),
                                        IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.youtube,
                                            size: width * 0.04,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {},
                                        ),

                                        SizedBox(
                                          width: width * 0.003,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: Text(
                                              "${StaticData.userModel!.YouTube}",
                                              style: TextStyle(
                                                  fontSize: width * 0.027,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                        )
                                      ],
                                    ),
                                  ),
                            StaticData.userModel!.Facebook == ""
                                ? SizedBox()
                                : Container(
                                    height: height * 0.035,
                                    width: width,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.facebook,
                                            size: width * 0.04,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {},
                                        ),
                                        SizedBox(
                                          width: width * 0.003,
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
                            StaticData.userModel!.Instagram == ""
                                ? SizedBox()
                                : Container(
                                    height: height * 0.035,
                                    width: width,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.instagram,
                                            size: width * 0.04,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () {},
                                        ),
                                        SizedBox(
                                          width: width * 0.003,
                                        ),
                                        Text(
                                            "${StaticData.userModel!.Instagram}",
                                            style: TextStyle(
                                                fontSize: width * 0.027,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                            StaticData.userModel!.TikTok == ""
                                ? SizedBox()
                                : Container(
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
                                          width: width * 0.003,
                                        ),
                                        Text("${StaticData.userModel!.TikTok}",
                                            style: TextStyle(
                                                fontSize: width * 0.027,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                            StaticData.userModel!.AboutMe == ""
                                ? SizedBox()
                                : Container(
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
                              height: height * 0.07,
                              width: width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentBookScreen(),
                                          ));
                                    },
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        height: height * 0.04,
                                        width: width * 0.35,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[200],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          "Book Now",
                                          style: TextStyle(
                                              fontSize: width * 0.05,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: height * 0.04,
                                      width: width * 0.35,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Message",
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: obj.toggleFavorite,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 18,
                                        child: Center(
                                          child: Icon(
                                            obj.isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: obj.isFavorite
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 25,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            obj.salonmodel!.SalonName == ""
                                ? SizedBox()
                                : Column(
                                    children: [
                                      Container(
                                        height: height * 0.028,
                                        width: width * 0.9,
                                        child: Text(
                                          "Visit Now",
                                          style: TextStyle(
                                            fontSize: width * 0.035,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          height: height * 0.09,
                                          width: width * 0.92,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 35,
                                              backgroundImage: obj.salonmodel!
                                                          .SalonPicture !=
                                                      ""
                                                  ? NetworkImage(obj.salonmodel!
                                                      .SalonPicture!) // Show the salon picture if available
                                                  : null, // If no salon picture, it will be null
                                              backgroundColor: Colors.pink[
                                                  200], // Background color if no image
                                              child: obj.salonmodel!
                                                          .SalonPicture ==
                                                      ""
                                                  ? const Icon(
                                                      Icons.camera_alt,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ) // Show camera icon if no salon picture is set
                                                  : null, // No icon if salon picture exists
                                            ),
                                            title: Text(
                                              "${obj.salonmodel!.SalonName}",
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
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SalonScreen(),
                                                    ));
                                              },
                                              child: Container(
                                                height: height * 0.04,
                                                width: width * 0.2,
                                                decoration: BoxDecoration(
                                                  color: Colors.pink[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "View Profile",
                                                    style: TextStyle(
                                                        fontSize: width * 0.03,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: height * 0.01,
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
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('offers')
                                      .where("userId",
                                          isEqualTo:
                                              StaticData.userModel!.UserId)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    }
                                    if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return const Center(
                                          child: Text('No offers available'));
                                    }

                                    final width =
                                        MediaQuery.of(context).size.width;
                                    return Container(
                                      width: width,
                                      height: height * 0.15,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          OfferModel model = OfferModel.fromMap(
                                              snapshot.data!.docs[index].data()
                                                  as Map<String, dynamic>);
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: width * 0.3,
                                                  height: height * 0.13,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          model.offerPic),
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
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
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
                                                Text('No services available'));
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
                                                ServiceModel.fromMap(doc.data()
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
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
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        model.serviceName ?? '',
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
                                                              TextOverflow.fade,
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
                                )
                              ],
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
                                Expanded(
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('specialists')
                                        .where("userId",
                                            isEqualTo:
                                                StaticData.userModel!.UserId)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
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

                                      final width =
                                          MediaQuery.of(context).size.width;
                                      final height =
                                          MediaQuery.of(context).size.height;

                                      // Convert Firestore docs to SpecialistModel list
                                      List<SpecialistModel> specialists =
                                          snapshot.data!.docs.map((doc) {
                                        return SpecialistModel.fromMap(
                                            doc.data() as Map<String, dynamic>);
                                      }).toList();

                                      return GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
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
                                            builder:
                                                (context, double value, child) {
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
                                                Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Container(
                                                    height: height * 0.22,
                                                    width: width * 0.43,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  pair.specialistPic ??
                                                                      ''),
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
                                                              Center(
                                                                child: Text(
                                                                  pair.specialistName ??
                                                                      '',
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
                                                              Center(
                                                                child: Text(
                                                                  pair.specialistServiceName ??
                                                                      '',
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
                                                                          5,
                                                                      starSize:
                                                                          12,
                                                                      starColor: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          241,
                                                                          134,
                                                                          170),
                                                                      valueLabelColor: const Color
                                                                              .fromRGBO(
                                                                          240,
                                                                          134,
                                                                          169,
                                                                          1),
                                                                      starSpacing:
                                                                          2,
                                                                      valueLabelVisibility:
                                                                          false,
                                                                    ),
                                                                    SizedBox(
                                                                        width: width *
                                                                            0.03),
                                                                    Text(
                                                                      '$rating',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
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
                            Column(
                              children: [
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Container(
                                  height: height * 0.035,
                                  width: width * 0.93,
                                  child: Text(
                                    " Products",
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
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection(
                                              'products') // Change to 'products' collection
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
                                                  'No products available'));
                                        }

                                        final width =
                                            MediaQuery.of(context).size.width;
                                        final height =
                                            MediaQuery.of(context).size.height;

                                        return Container(
                                          height: height * 0.15,
                                          width: width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              ProductModel model =
                                                  ProductModel.fromMap(snapshot
                                                          .data!.docs[index]
                                                          .data()
                                                      as Map<String, dynamic>);
                                              return GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         const BeautyProductScreen(),
                                                  //   ),
                                                  // );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: width * 0.3,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                model.productPic ??
                                                                    ''),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 10,
                                                        left: 0,
                                                        child: Container(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          width: width * 0.3,
                                                          child: Text(
                                                            '\$${model.productPrice}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
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
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('recentworks')
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
                                              child: Text('No Work available'));
                                        }

                                        final width =
                                            MediaQuery.of(context).size.width;
                                        final height =
                                            MediaQuery.of(context).size.height;

                                        return Container(
                                          height: height * 0.15,
                                          width: width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> docData =
                                                  snapshot.data!.docs[index]
                                                          .data()
                                                      as Map<String, dynamic>;

                                              RecentWorkModel model =
                                                  RecentWorkModel.fromMap(
                                                      docData);

                                              String recentWorkPic =
                                                  model.RecentworkPic ?? '';
                                              String recentWorkId =
                                                  model.RecentworkId ?? '';

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      width: width * 0.3,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              recentWorkPic),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                ),
                                SizedBox(
                                  height: height * 0.02,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: TweenAnimationBuilder(
                                      tween:
                                          Tween<double>(begin: 0.0, end: 1.0),
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
                                                starSize:
                                                    12, // Size of the stars
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
    });
  }
}
