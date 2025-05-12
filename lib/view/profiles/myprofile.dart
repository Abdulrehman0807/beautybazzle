import 'package:animations/animations.dart';
import 'package:beautybazzle/controller/profile/editprofilecontroller.dart';
import 'package:beautybazzle/model/addoffer/addoffer.dart';
import 'package:beautybazzle/model/addproduct/addproduct.dart';
import 'package:beautybazzle/model/addspecialist/addspecialist.dart';
import 'package:beautybazzle/model/addwork/addwork.dart';
import 'package:beautybazzle/model/addservice/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/bottom_bar/bottom_Nav_bar.dart';
import 'package:beautybazzle/view/profiles/editProfile.dart';
import 'package:beautybazzle/view/setting/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../model/addservice/addservices.dart';

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
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavBar(),
                                  ));
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.25,
                          ),
                          obj.usermodel == null || obj.usermodel!.name == ""
                              ? const SizedBox()
                              : Text(
                                  "${obj.usermodel!.name}",
                                  style: TextStyle(
                                    fontSize: width * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        height: height * 0.13,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.04,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: obj.usermodel != null &&
                                      obj.usermodel!.ProfilePicture != null &&
                                      obj.usermodel!.ProfilePicture!.isNotEmpty
                                  ? NetworkImage(obj.usermodel!.ProfilePicture!)
                                  : null,
                              backgroundColor: Colors.pink[200],
                              child: obj.usermodel == null ||
                                      obj.usermodel!.ProfilePicture == null ||
                                      obj.usermodel!.ProfilePicture!.isEmpty
                                  ? const Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  : null,
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
                          child: Column(children: [
                            obj.usermodel == null || obj.usermodel!.name == ""
                                ? const SizedBox()
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
                                ? const SizedBox()
                                : Container(
                                    height: height * 0.035,
                                    width: width * 0.95,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on),
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
                                ? const SizedBox()
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
                                ? const SizedBox()
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
                                ? const SizedBox()
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
                                ? const SizedBox()
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
                                ? const SizedBox()
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
                                        "${obj.usermodel!.AboutMe}",
                                        style: TextStyle(
                                            fontSize: width * 0.036,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.fade),
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
                                  OpenContainer(
                                    transitionType:
                                        ContainerTransitionType.fadeThrough,
                                    transitionDuration:
                                        const Duration(seconds: 1),
                                    openBuilder: (context, _) =>
                                        const EditProfileScreen(),
                                    closedElevation: 0,
                                    closedBuilder: (context, _) => Container(
                                        height: height * 0.05,
                                        width: width * 0.8,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Edit Profile",
                                            style: TextStyle(
                                              fontSize: width * 0.05,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingScreen()),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.settings,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            obj.salonmodel == null ||
                                    obj.salonmodel!.SalonName == ""
                                ? const SizedBox(
                                    height: 500,
                                    width: 500,
                                    child: Center(
                                        child: Text(
                                      "No available data edit a profile ",
                                      style: TextStyle(fontSize: 17),
                                    )),
                                  )
                                : SingleChildScrollView(
                                    child: Column(children: [
                                    Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        height: height * 0.09,
                                        width: width * 0.92,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 35,
                                            backgroundImage:
                                                obj.salonmodel != null &&
                                                        obj.salonmodel!
                                                                .SalonPicture !=
                                                            null &&
                                                        obj
                                                            .salonmodel!
                                                            .SalonPicture!
                                                            .isNotEmpty
                                                    ? NetworkImage(obj
                                                        .salonmodel!
                                                        .SalonPicture!)
                                                    : null,
                                            backgroundColor: Colors.pink[200],
                                            child: obj.salonmodel == null ||
                                                    obj.salonmodel!
                                                            .SalonPicture ==
                                                        null ||
                                                    obj.salonmodel!
                                                        .SalonPicture!.isEmpty
                                                ? const Icon(
                                                    Icons.camera_alt,
                                                    size: 30,
                                                    color: Colors.white,
                                                  )
                                                : null,
                                          ),
                                          title: Text(
                                            "${obj.salonmodel!.SalonName}",
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
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.12,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    obj.pickVideo(context),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                      radius: 27,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.black45,
                                                      )),
                                                ),
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
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('highlight_videos')
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
                                                        'No videos available'));
                                              }

                                              // Get the video data from Firestore
                                              final videoDocs =
                                                  snapshot.data!.docs;

                                              return Container(
                                                height: height * 0.07,
                                                width: width * 0.8,
                                                // color: Colors.amber,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: videoDocs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final videoData =
                                                        videoDocs[index].data()
                                                            as Map<String,
                                                                dynamic>;
                                                    final videoUrl = videoData[
                                                            'highlightVideo'] ??
                                                        '';
                                                    final thumbnailUrl =
                                                        videoData[
                                                                'thumbnailUrl'] ??
                                                            '';

                                                    return GestureDetector(
                                                      onTap: () =>
                                                          obj.showVideoDialog(
                                                              context,
                                                              videoUrl),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  thumbnailUrl),
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors
                                                                    .pink[200],
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .play_circle_filled,
                                                                color: Colors
                                                                    .white,
                                                                size: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
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
                                      tween:
                                          Tween<double>(begin: 0.0, end: 1.0),
                                      duration:
                                          const Duration(milliseconds: 1000),
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
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 8.0,
                                                  bottom: 8.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    obj.showAddOfferDialog(
                                                        context, height, width),
                                                child: Container(
                                                    height: height * 0.13,
                                                    width: width * 0.28,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black45),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.camera_alt,
                                                        size: width * 0.1,
                                                        color: Colors.black45,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            Expanded(
                                              child:
                                                  StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('offers')
                                                    .where("userId",
                                                        isEqualTo: StaticData
                                                            .userModel!.UserId)
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
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
                                                      snapshot
                                                          .data!.docs.isEmpty) {
                                                    return const Center(
                                                        child: Text(
                                                            'No offers available'));
                                                  }

                                                  final width =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;
                                                  return Container(
                                                    height: height,
                                                    width: width,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        OfferModel model = OfferModel
                                                            .fromMap(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>);
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                width:
                                                                    width * 0.3,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black45),
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: NetworkImage(
                                                                        model
                                                                            .offerPic),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 0,
                                                                right: 0,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.05,
                                                                  width: width *
                                                                      0.1,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                              .pink[
                                                                          200]),
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .white),
                                                                    onPressed:
                                                                        () {
                                                                      // Show a confirmation dialog
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text("Delete Offer"),
                                                                            content:
                                                                                const Text("Are you sure you want to delete this offer?"),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                                },
                                                                                child: const Text("Cancel"),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                                  obj.deleteOffer(model.offerId); // Delete the offer
                                                                                },
                                                                                child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
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
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      width: width,
                                      child: const TabBar(
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
                                        height: UserModel1.mylist.length *
                                            height *
                                            0.16,
                                        width: width,
                                        child: TabBarView(children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      obj.showAddServiceDialog(
                                                          context,
                                                          width,
                                                          height),
                                                  child: Container(
                                                    height: height * 0.09,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black12,
                                                            width:
                                                                width * 0.002)),
                                                    child: Center(
                                                        child: Text(
                                                      "Add a Services ",
                                                      style: TextStyle(
                                                          fontSize:
                                                              width * 0.05,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                        'services') // Your 'services' collection
                                                    .where("userId",
                                                        isEqualTo: StaticData
                                                            .userModel!.UserId)
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  // Handle connection states and errors
                                                  if (snapshot
                                                          .connectionState ==
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
                                                      snapshot
                                                          .data!.docs.isEmpty) {
                                                    return const Center(
                                                        child: Text(
                                                            'No services available'));
                                                  }

                                                  final width =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;

                                                  return Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((doc) {
                                                        // Ensure that the Firestore document is parsed into the model correctly
                                                        ServiceModel model =
                                                            ServiceModel
                                                                .fromMap(doc
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>);

                                                        return TweenAnimationBuilder(
                                                          tween: Tween<double>(
                                                              begin: 0.0,
                                                              end: 1.0),
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      800),
                                                          curve: Curves.easeOut,
                                                          builder: (context,
                                                              double value,
                                                              child) {
                                                            return Opacity(
                                                              opacity: value,
                                                              child: Transform
                                                                  .translate(
                                                                offset: Offset(
                                                                    0,
                                                                    50 *
                                                                        (1 -
                                                                            value)),
                                                                child: child,
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Container(
                                                              height:
                                                                  height * 0.12,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: width *
                                                                        0.002),
                                                              ),
                                                              child: Center(
                                                                child: ListTile(
                                                                  leading:
                                                                      Container(
                                                                    height:
                                                                        height *
                                                                            0.07,
                                                                    width:
                                                                        width *
                                                                            0.15,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(model.servicePic ??
                                                                            ''), // Safe access
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  title: Text(
                                                                    model.serviceName ??
                                                                        '',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.04,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    model.serviceDescription ??
                                                                        '',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.028,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                    ),
                                                                  ),
                                                                  trailing:
                                                                      PopupMenuButton<
                                                                          String>(
                                                                    onSelected:
                                                                        (String
                                                                            value) {
                                                                      if (value ==
                                                                          'delete') {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: const Text("Delete Service"),
                                                                              content: const Text("Are you sure you want to delete this service?"),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: const Text("Cancel"),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                    obj.deleteService(context, model.serviceId);
                                                                                  },
                                                                                  child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return [
                                                                        PopupMenuItem<
                                                                            String>(
                                                                          value:
                                                                              'delete',
                                                                          child:
                                                                              Row(
                                                                            children: const [
                                                                              Icon(Icons.delete, color: Colors.red),
                                                                              SizedBox(width: 8),
                                                                              Text('Delete'),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ];
                                                                    },
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
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: GestureDetector(
                                                  onTap: () => obj
                                                      .showAddSpecialistDialog(
                                                          context,
                                                          width,
                                                          height),
                                                  child: Container(
                                                    height: height * 0.09,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black12,
                                                            width:
                                                                width * 0.002)),
                                                    child: Center(
                                                        child: Text(
                                                      "Add a Specialist ",
                                                      style: TextStyle(
                                                          fontSize:
                                                              width * 0.05,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              Expanded(
                                                child: StreamBuilder<
                                                    QuerySnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('specialists')
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
                                                              'No Specialists available'));
                                                    }

                                                    final width =
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width;
                                                    final height =
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height;

                                                    // Convert Firestore docs to SpecialistModel list
                                                    List<SpecialistModel>
                                                        specialists = snapshot
                                                            .data!.docs
                                                            .map((doc) {
                                                      return SpecialistModel
                                                          .fromMap(doc.data()
                                                              as Map<String,
                                                                  dynamic>);
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
                                                      padding: const EdgeInsets
                                                              .all(
                                                          8.0), // padding around the grid
                                                      itemCount: specialists
                                                          .length, // total number of items
                                                      itemBuilder:
                                                          (context, index) {
                                                        SpecialistModel pair =
                                                            specialists[index];
                                                        return TweenAnimationBuilder(
                                                          tween: Tween<double>(
                                                              begin: 0.0,
                                                              end: 1.0),
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      800),
                                                          curve: Curves.easeOut,
                                                          builder: (context,
                                                              double value,
                                                              child) {
                                                            return Opacity(
                                                              opacity: value,
                                                              child: Transform
                                                                  .translate(
                                                                offset: Offset(
                                                                    0,
                                                                    50 *
                                                                        (1 -
                                                                            value)),
                                                                child: child,
                                                              ),
                                                            );
                                                          },
                                                          child: Stack(
                                                            children: [
                                                              Card(
                                                                elevation: 2,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.22,
                                                                  width: width *
                                                                      0.43,
                                                                  decoration:
                                                                      BoxDecoration(
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
                                                                        radius:
                                                                            30,
                                                                        backgroundImage:
                                                                            NetworkImage(pair.specialistPic ??
                                                                                ''),
                                                                      ),
                                                                      Container(
                                                                        height: height *
                                                                            0.08,
                                                                        width:
                                                                            width,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Center(
                                                                              child: Text(
                                                                                pair.specialistName ?? '',
                                                                                style: TextStyle(
                                                                                  fontSize: width * 0.032,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  overflow: TextOverflow.clip,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Center(
                                                                              child: Text(
                                                                                pair.specialistServiceName ?? '',
                                                                                style: TextStyle(
                                                                                  fontSize: width * 0.032,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  overflow: TextOverflow.fade,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
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
                                                              Positioned(
                                                                top: 0,
                                                                right: 0,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.05,
                                                                  width: width *
                                                                      0.1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                            .pink[
                                                                        200],
                                                                  ),
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .white),
                                                                    onPressed:
                                                                        () {
                                                                      // Show a confirmation dialog
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text("Delete Specialist"),
                                                                            content:
                                                                                const Text("Are you sure you want to delete this specialist?"),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                                },
                                                                                child: const Text("Cancel"),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(); // Close the dialog
                                                                                  if (pair.specialistId != null) {
                                                                                    obj.deleteSpecialist(context, pair.specialistId!); // Call deleteSpecialist
                                                                                  }
                                                                                },
                                                                                child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
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
                                                  "Special Offer Products",
                                                  style: TextStyle(
                                                    fontSize: width * 0.04,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                              TweenAnimationBuilder(
                                                tween: Tween<double>(
                                                    begin: 0.0, end: 1.0),
                                                duration: const Duration(
                                                    milliseconds: 1000),
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
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              top: 8,
                                                              bottom: 8),
                                                      child: GestureDetector(
                                                        onTap: () => obj
                                                            .showAddProductDialog(
                                                                context,
                                                                width,
                                                                height),
                                                        child: Container(
                                                          width: width * 0.3,
                                                          height: height * 0.13,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black45),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Icon(
                                                            Icons.camera_alt,
                                                            size: width * 0.1,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: StreamBuilder<
                                                          QuerySnapshot>(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'products') // Change to 'products' collection
                                                            .where("userId",
                                                                isEqualTo:
                                                                    StaticData
                                                                        .userModel!
                                                                        .UserId)
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
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
                                                          if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'));
                                                          }
                                                          if (!snapshot
                                                                  .hasData ||
                                                              snapshot
                                                                  .data!
                                                                  .docs
                                                                  .isEmpty) {
                                                            return const Center(
                                                                child: Text(
                                                                    'No products available'));
                                                          }

                                                          final width =
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width;
                                                          final height =
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height;

                                                          return Container(
                                                            height:
                                                                height * 0.15,
                                                            width: width,
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                ProductModel
                                                                    model =
                                                                    ProductModel.fromMap(snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .data()
                                                                        as Map<
                                                                            String,
                                                                            dynamic>);
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    // Navigator
                                                                    //     .push(
                                                                    //   context,
                                                                    //   MaterialPageRoute(
                                                                    //     builder:
                                                                    //         (context) =>
                                                                    //             const BeautyProductScreen(),
                                                                    //   ),
                                                                    // );
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              width * 0.3,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.black45),
                                                                            image:
                                                                                DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: NetworkImage(model.productPic ?? ''),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              0,
                                                                          right:
                                                                              0,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                height * 0.05,
                                                                            width:
                                                                                width * 0.1,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: Colors.pink[200],
                                                                            ),
                                                                            child:
                                                                                IconButton(
                                                                              icon: const Icon(Icons.delete, color: Colors.white),
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return AlertDialog(
                                                                                      title: const Text("Delete Product"),
                                                                                      content: const Text("Are you sure you want to delete this Product?"),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            Navigator.of(context).pop();
                                                                                          },
                                                                                          child: const Text("Cancel"),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            Navigator.of(context).pop();
                                                                                            obj.deleteProduct(context, model.productId!);
                                                                                          },
                                                                                          child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          bottom:
                                                                              10,
                                                                          left:
                                                                              0,
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.black.withOpacity(0.5),
                                                                            width:
                                                                                width * 0.3,
                                                                            child:
                                                                                Text(
                                                                              '\$${model.productPrice}',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                              ),
                                                                              textAlign: TextAlign.center,
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
                                                    )
                                                  ],
                                                ),
                                              ),

                                              TweenAnimationBuilder(
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
                                                child: Container(
                                                  height: height * 0.035,
                                                  width: width * 0.93,
                                                  child: Text(
                                                    "Recent Work",
                                                    style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TweenAnimationBuilder(
                                                tween: Tween<double>(
                                                    begin: 0.0, end: 1.0),
                                                duration: const Duration(
                                                    milliseconds: 1000),
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
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              top: 8,
                                                              bottom: 8),
                                                      child: GestureDetector(
                                                        onTap: () => obj
                                                            .showAddRecentWorkDialog(
                                                                context,
                                                                width,
                                                                height),
                                                        child: Container(
                                                          width: width * 0.3,
                                                          height: height * 0.13,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black45),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Icon(
                                                            Icons.camera_alt,
                                                            size: width * 0.1,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: StreamBuilder<
                                                          QuerySnapshot>(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'recentworks')
                                                            .where("userId",
                                                                isEqualTo:
                                                                    StaticData
                                                                        .userModel!
                                                                        .UserId)
                                                            .snapshots(),
                                                        builder: (BuildContext
                                                                context,
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

                                                          if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'));
                                                          }

                                                          if (!snapshot
                                                                  .hasData ||
                                                              snapshot
                                                                  .data!
                                                                  .docs
                                                                  .isEmpty) {
                                                            return const Center(
                                                                child: Text(
                                                                    'No Work available'));
                                                          }

                                                          final width =
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width;
                                                          final height =
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height;

                                                          return Container(
                                                            height:
                                                                height * 0.15,
                                                            width: width,
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                Map<String,
                                                                    dynamic> docData = snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;

                                                                RecentWorkModel
                                                                    model =
                                                                    RecentWorkModel
                                                                        .fromMap(
                                                                            docData);

                                                                String
                                                                    recentWorkPic =
                                                                    model.RecentworkPic ??
                                                                        '';
                                                                String
                                                                    recentWorkId =
                                                                    model.RecentworkId ??
                                                                        '';

                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        width: width *
                                                                            0.3,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.black45),
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image:
                                                                                NetworkImage(recentWorkPic),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top: 0,
                                                                        right:
                                                                            0,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              height * 0.05,
                                                                          width:
                                                                              width * 0.1,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Colors.pink[200],
                                                                          ),
                                                                          child:
                                                                              IconButton(
                                                                            icon:
                                                                                const Icon(Icons.delete, color: Colors.white),
                                                                            onPressed:
                                                                                () {
                                                                              // Show a confirmation dialog
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    title: const Text("Delete Recent Work"),
                                                                                    content: const Text("Are you sure you want to delete this recent work?"),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop(); // Close the dialog
                                                                                        },
                                                                                        child: const Text("Cancel"),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.of(context).pop(); // Close the dialog
                                                                                          // Make sure you have a valid object for obj
                                                                                          if (recentWorkId.isNotEmpty) {
                                                                                            obj.deleteWork(context, recentWorkId); // Call deletework
                                                                                          }
                                                                                        },
                                                                                        child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                          ),
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),

                                              // Repeated animation structure for "Tips and Tricks"
                                              TweenAnimationBuilder(
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
                                                child: Container(
                                                  height: height * 0.03,
                                                  width: width * 0.93,
                                                  child: Text(
                                                    "Tips and Tricks",
                                                    style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              TweenAnimationBuilder(
                                                tween: Tween<double>(
                                                    begin: 0.0, end: 1.0),
                                                duration: const Duration(
                                                    milliseconds: 1000),
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
                                                child: Container(
                                                  height: height * 0.25,
                                                  child: ListView.builder(
                                                    itemCount: 1,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10,
                                                                left: 15.0,
                                                                right: 10),
                                                        child: Container(
                                                          height: height * 0.22,
                                                          width: width * 0.92,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.brown,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                UserModel1.mylist.map((item) {
                                              return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  child: TweenAnimationBuilder(
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
                                                              (1 - value) * 50),
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
                                                                AssetImage(
                                                                    StaticData
                                                                        .myDp),
                                                          ),
                                                          title: Text(
                                                            "The makeup session was flawless and lasted the entire event without a touch-up. So professional!",
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
                                                          subtitle: Container(
                                                            height:
                                                                height * 0.03,
                                                            child: RatingStars(
                                                              value: rating,
                                                              onValueChanged:
                                                                  (newRating) {},
                                                              starCount:
                                                                  5, // Number of stars
                                                              starSize:
                                                                  12, // Size of the stars
                                                              starColor: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  241,
                                                                  134,
                                                                  170),
                                                              valueLabelColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      240,
                                                                      134,
                                                                      169,
                                                                      1),
                                                              starSpacing:
                                                                  2, // Space between the stars
                                                              valueLabelVisibility:
                                                                  true,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                            }).toList(),
                                          ),
                                        ])),
                                  ])),
                          ])),
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
