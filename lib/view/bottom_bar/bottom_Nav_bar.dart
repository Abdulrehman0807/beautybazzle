import 'package:beautybazzle/controller/profile/editprofilecontroller.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/dashboard/Dashboard.dart';
import 'package:beautybazzle/view/appoinment/apponiment_reminder.dart';
import 'package:beautybazzle/view/favourite_screen/favorite_screen.dart';
import 'package:beautybazzle/view/profiles/myprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaped_bottom_bar/models/shaped_item_object.dart';
import 'package:shaped_bottom_bar/shaped_bottom_bar.dart';
import 'package:shaped_bottom_bar/utils/arrays.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  // List of screens to navigate to
  final List<Widget> screens = [
    const DashboardScreen(),
    const FavoriteScreen(),
    const AppointmentReminderScreen(),
    const MyProfileScreen()
  ];

  @override
  void initState() {
    Get.put(ProfileController());
    ProfileController.to.getUserProfile(StaticData.userModel!.UserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: ShapedBottomBar(
        backgroundColor: Colors.white,
        iconsColor: Colors.black,
        listItems: [
          ShapedItemObject(iconData: Icons.home, title: "Home"),
          ShapedItemObject(iconData: Icons.favorite, title: "Favorite"),
          ShapedItemObject(iconData: Icons.menu_book, title: "Booking"),
          ShapedItemObject(iconData: Icons.person, title: "Profile"),
        ],
        onItemChanged: (position) {
          setState(() {
            this.selectedIndex = position;
          });
        },
        shape: ShapeType.RHOMBUS,
        shapeColor: const Color(0xFFF48FB1),
        selectedIconColor: Colors.white,
        with3dEffect: true,
        animationType: ANIMATION_TYPE.SLIDE_VERTICALLY,
      ),
    );
  }
}
