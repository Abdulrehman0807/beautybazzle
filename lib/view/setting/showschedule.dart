import 'package:beautybazzle/controller/profile/editprofilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For the spinner

class SalonSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<ProfileController>(
      builder: (obj) {
        return Scaffold(
          body: Stack(
            children: [
              // Main content of the screen
              Container(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.032),
                    Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            "Set Your Salon Schedule",
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.schedule,
                                size: 26, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              for (int index = 0;
                                  index < obj.officeStatus.keys.length;
                                  index++)
                                TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0, end: 1),
                                  duration: Duration(
                                      milliseconds: 500 +
                                          (index * 100)), // Staggered animation
                                  curve: Curves.easeInOut,
                                  builder: (context, double value, child) {
                                    return Opacity(
                                      opacity: value,
                                      child: Transform.translate(
                                        offset: Offset(
                                            0,
                                            (1 - value) *
                                                20), // Slide-up effect
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17.0, right: 17),
                                    child: Card(
                                      elevation: 4,
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.pink[200],
                                                      radius: 17,
                                                      child: Icon(
                                                        Icons
                                                            .access_time_filled,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width * 0.04),
                                                    Text(
                                                      obj.officeStatus.keys
                                                          .elementAt(index),
                                                      style: TextStyle(
                                                        fontSize: width * 0.045,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Switch(
                                                  value: obj.officeStatus[obj
                                                      .officeStatus.keys
                                                      .elementAt(index)]!,
                                                  onChanged: (bool value) {
                                                    obj.officeStatus[obj
                                                            .officeStatus.keys
                                                            .elementAt(index)] =
                                                        value;
                                                    obj.update(); // Update UI
                                                  },
                                                  activeColor: Colors.green,
                                                  inactiveThumbColor:
                                                      Colors.grey,
                                                ),
                                              ],
                                            ),
                                            if (obj.officeStatus[obj
                                                .officeStatus.keys
                                                .elementAt(index)]!)
                                              Column(
                                                children: [
                                                  SizedBox(
                                                      height: height * 0.01),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Opening Time: ${obj.officeOpenTimes[obj.officeStatus.keys.elementAt(index)]}",
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.04,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(Icons.edit,
                                                            color: Colors.blue),
                                                        onPressed: () =>
                                                            obj.pickTime(
                                                                context,
                                                                obj.officeStatus
                                                                    .keys
                                                                    .elementAt(
                                                                        index),
                                                                true),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Closing Time: ${obj.officeCloseTimes[obj.officeStatus.keys.elementAt(index)]}",
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.04,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(Icons.edit,
                                                            color: Colors.blue),
                                                        onPressed: () =>
                                                            obj.pickTime(
                                                                context,
                                                                obj.officeStatus
                                                                    .keys
                                                                    .elementAt(
                                                                        index),
                                                                false),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            if (!obj.officeStatus[obj
                                                .officeStatus.keys
                                                .elementAt(index)]!)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "Closed",
                                                  style: TextStyle(
                                                    fontSize: width * 0.04,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(height: height * 0.03),
                              ElevatedButton(
                                onPressed: () async {
                                  await obj.saveScheduleToFirebase(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 160, vertical: 10),
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Loading spinner if isLoading is true
              if (obj.isLoading)
                Container(
                  height: height,
                  width: width,
                  color: Colors.pink.withOpacity(0.3),
                  child: Center(
                    child: SpinKitSpinningLines(color: Colors.pink),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
