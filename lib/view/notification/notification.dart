import 'package:beautybazzle/model/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
            _buildHeader(context, width),
            Expanded(
              child: _buildNotificationList(height, width),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the header section of the notification screen
  Widget _buildHeader(BuildContext context, double width) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      height: 60,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(Icons.arrow_back, Colors.black, () {
            Navigator.pop(context);
          }),
          Text(
            "Notification",
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          _buildIconButton(Icons.notifications, Colors.black, null),
        ],
      ),
    );
  }

  /// Builds a circular icon button
  Widget _buildIconButton(IconData icon, Color iconColor, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white,
        child: Icon(icon, size: 24, color: iconColor),
      ),
    );
  }

  /// Builds the notification list with animations
  Widget _buildNotificationList(double height, double width) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: UserModel4.mylist.length,
      itemBuilder: (context, index) {
        return _buildNotificationItem(
          height: height,
          width: width,
          notification: UserModel4.mylist[index].notification!,
        );
      },
    );
  }

  /// Builds a single notification item with animation
  Widget _buildNotificationItem({
    required double height,
    required double width,
    required String notification,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Card(
                elevation: 0.4,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.pink[200],
                    backgroundImage: AssetImage(StaticData.myLogo),
                  ),
                  title: Text(
                    notification,
                    style: TextStyle(fontSize: width * 0.04),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
