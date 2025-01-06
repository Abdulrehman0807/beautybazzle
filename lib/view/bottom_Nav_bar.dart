import 'package:beautybazzle/view/Dashboard.dart';
import 'package:beautybazzle/view/apponiment_reminder.dart';
import 'package:beautybazzle/view/favorite_screen.dart';
import 'package:beautybazzle/view/myprofile.dart';
import 'package:flutter/material.dart';
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
