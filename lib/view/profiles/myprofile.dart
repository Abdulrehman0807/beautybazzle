import 'package:beautybazzle/controller/editprofilecontroller.dart';
import 'package:beautybazzle/model/addoffer.dart';

import 'package:beautybazzle/model/servic_data.dart';

import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/categorie/beauty_product.dart';
import 'package:beautybazzle/view/profiles/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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
                                  : null, // Show profile picture if available, otherwise default background color
                              backgroundColor: Colors.blue[200],
                              child: obj.usermodel!.ProfilePicture == ""
                                  ? const Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.white,
                                    ) // Show the camera icon if no profile picture is set
                                  : null, // No icon if profile picture exists
                            ),
                            if (obj.isLoadingProfile)
                              const SpinKitSpinningLines(
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            obj.usermodel == null || obj.usermodel!.name == ""
                                ? SizedBox()
                                : Center(
                                    child: Container(
                                      height: height * 0.045,
                                      width: width * 0.95,
                                      child: Text(
                                        "${obj.usermodel!.name}",
                                        style: TextStyle(
                                            fontSize: width * 0.06,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                            obj.usermodel == null ||
                                    obj.usermodel!.Address == ""
                                ? SizedBox()
                                : Container(
                                    height: height * 0.035,
                                    width: width * 0.95,
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        Text(
                                          "${obj.usermodel!.Address}",
                                          style:
                                              TextStyle(fontSize: width * 0.04),
                                        )
                                      ],
                                    ),
                                  ),
                            obj.usermodel == null ||
                                    obj.usermodel!.YouTube == ""
                                ? SizedBox()
                                : Container(
                                    height: height * 0.038,
                                    width: width,
                                    child: Row(
                                      children: [
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
                                              "${obj.usermodel!.YouTube}",
                                              style: TextStyle(
                                                  fontSize: width * 0.028,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                        )
                                      ],
                                    ),
                                  ),
                            obj.usermodel == null ||
                                    obj.usermodel!.Facebook == ""
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
                                          "${obj.usermodel!.Facebook}",
                                          style: TextStyle(
                                              fontSize: width * 0.027,
                                              overflow: TextOverflow.ellipsis),
                                        )
                                      ],
                                    ),
                                  ),
                            obj.usermodel == null ||
                                    obj.usermodel!.Instagram == ""
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
                                        Text("${obj.usermodel!.Instagram}",
                                            style: TextStyle(
                                                fontSize: width * 0.027,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                            obj.usermodel == null || obj.usermodel!.TikTok == ""
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
                                        Text("${obj.usermodel!.TikTok}",
                                            style: TextStyle(
                                                fontSize: width * 0.027,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                            obj.usermodel == null ||
                                    obj.usermodel!.AboutMe == ""
                                ? SizedBox()
                                : Container(
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
                                        "${obj.usermodel!.AboutMe}",
                                        style: TextStyle(
                                            fontSize: width * 0.036,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.fade),
                                      ),
                                    ),
                                  ),
                            obj.usermodel == null ||
                                    obj.usermodel!.SalonName == ""
                                ? SizedBox()
                                : Container(
                                    height: height * 0.09,
                                    width: width * 0.92,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 28,
                                        backgroundImage: NetworkImage(
                                            StaticData.userModel!.SalonPicture),
                                      ),
                                      title: Text(
                                        "${obj.usermodel!.SalonName}",
                                        style: TextStyle(
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${obj.usermodel!.Address}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          border:
                                              Border.all(color: Colors.black),
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
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0, bottom: 8.0),
                                    child: Container(
                                      height: height * 0.13,
                                      width: width * 0.28,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black45),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: GestureDetector(
                                        onTap: () =>
                                            obj.showOfferDialog(context),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: width * 0.1,
                                          color: Colors.black45,
                                        ),
                                      )),
                                    ),
                                  ),
                                  // Expanded(
                                  //   child:

                                  //  Container(
                                  //   height: height * 0.15,
                                  //   width: width,
                                  //   child: ListView.builder(
                                  //     itemCount: 5,
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemBuilder: (context, index) {
                                  //       return Padding(
                                  //         padding: const EdgeInsets.all(8),
                                  //         child: Container(
                                  //           width: width * 0.3,
                                  //           decoration: BoxDecoration(
                                  //             image: DecorationImage(
                                  //                 fit: BoxFit.cover,
                                  //                 image: AssetImage(
                                  //                     "images/offer.jpeg")),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),

                                  Expanded(
                                    child: StreamBuilder<List<OfferModel>>(
                                      stream: obj
                                          .getOffers(), // Ensure this returns a Stream<List<OfferModel>>
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        }
                                        if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return Center(
                                              child:
                                                  Text('No offers available'));
                                        }

                                        final offers = snapshot.data!;
                                        final width = MediaQuery.of(context)
                                            .size
                                            .width; // Make sure width is defined here
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: offers.length,
                                          itemBuilder: (context, index) {
                                            final offer = offers[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: width *
                                                        0.3, // Ensures the width is correctly set
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            offer.offerPic),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: IconButton(
                                                      icon: Icon(Icons.delete,
                                                          color: Colors.red),
                                                      onPressed: () =>
                                                          obj.deleteOffer(offer
                                                              .offerId), // Ensure this method is defined in _controller
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )

                                  // ),
                                ],
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
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Center(
                                                child: Text("Add a Service")),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: Colors.amber,
                                                  child: Icon(Icons.camera_alt),
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Container(
                                                  width: width,
                                                  child: TextFormField(
                                                    controller: obj
                                                        .servicnameController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Service Name"),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.03,
                                                ),
                                                Container(
                                                  width: width,
                                                  child: TextFormField(
                                                    controller: obj
                                                        .servicdescriptionController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Description"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () async {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.pink[200],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 50,
                                                        vertical: 10),
                                                  ),
                                                  child: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: height * 0.09,
                                      width: width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: width * 0.002)),
                                      child: Center(
                                          child: Text(
                                        "Add a Services ",
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  ),
                                ),
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
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Center(
                                                child: Text("Add a Service")),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: Colors.amber,
                                                  child: Icon(Icons.camera_alt),
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Container(
                                                  width: width,
                                                  child: TextFormField(
                                                    controller: obj
                                                        .servicnameController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Specialist Name"),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.03,
                                                ),
                                                Container(
                                                  width: width,
                                                  child: TextFormField(
                                                    controller: obj
                                                        .servicdescriptionController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Add Service"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () async {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.pink[200],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 50,
                                                        vertical: 10),
                                                  ),
                                                  child: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: height * 0.09,
                                      width: width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: width * 0.002)),
                                      child: Center(
                                          child: Text(
                                        "Add a Specialist ",
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ),
                                  ),
                                ),
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
                                                          AssetImage(
                                                              item.image!),
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
                                                              style: TextStyle(
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
                                                                      Color.fromRGBO(
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
                                                          AssetImage(
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
                                                              style: TextStyle(
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
                                                                      Color.fromRGBO(
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
                                                image: AssetImage(
                                                    "images/work.jpg"),
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
