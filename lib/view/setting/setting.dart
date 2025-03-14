import 'package:beautybazzle/controller/profile/editprofilecontroller.dart';

import 'package:beautybazzle/view/setting/showschedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<ProfileController>(builder: (obj) {
      return Scaffold(
          body: Container(
        child: Column(children: [
          SizedBox(
            height: height * 0.032,
          ),
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
                "Settings",
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
                    const Icon(Icons.settings, size: 26, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SalonSchedule()),
              );
            },
            child: Container(
              height: height * 0.06,
              width: width * 0.96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Schedule",
                    style: TextStyle(
                        fontSize: width * 0.06, fontWeight: FontWeight.w500),
                  ),
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.chevron_right,
                      size: width * 0.07,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: height * 0.06,
              width: width * 0.96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Schedule",
                    style: TextStyle(
                        fontSize: width * 0.06, fontWeight: FontWeight.w500),
                  ),
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.chevron_right,
                      size: width * 0.07,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: height * 0.06,
            width: width * 0.96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Schedule",
                  style: TextStyle(
                      fontSize: width * 0.06, fontWeight: FontWeight.w500),
                ),
                CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.chevron_right,
                    size: width * 0.07,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: height * 0.06,
            width: width * 0.96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Schedule",
                  style: TextStyle(
                      fontSize: width * 0.06, fontWeight: FontWeight.w500),
                ),
                CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.chevron_right,
                    size: width * 0.07,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            // onTap: () => obj.LOginSignupController.to.logout(context),
            child: Container(
              height: height * 0.06,
              width: width * 0.96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "logout",
                    style: TextStyle(
                        fontSize: width * 0.06, fontWeight: FontWeight.w500),
                  ),
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.chevron_right,
                      size: width * 0.07,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ));
    });
  }
}
