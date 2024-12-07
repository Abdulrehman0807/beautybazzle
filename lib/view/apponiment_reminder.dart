import 'package:beautybazzle/view/bottom_Nav_bar.dart';
import 'package:flutter/material.dart';

class AppointmentReminderScreen extends StatefulWidget {
  const AppointmentReminderScreen({super.key});

  @override
  State<AppointmentReminderScreen> createState() =>
      _AppointmentReminderScreenState();
}

class _AppointmentReminderScreenState extends State<AppointmentReminderScreen> {
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
          SizedBox(
            height: height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              Text(
                "Appoinment Reminder",
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
                    const Icon(Icons.menu_book, size: 26, color: Colors.black),
              ),
            ],
          ),
          Expanded(
            child: Container(
                height: height,
                width: width,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: height * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            title: Text(
                              "Appoinment Confrimed",
                              style: TextStyle(
                                fontSize: width * 0.042,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Text(
                              "Your Appoinment is set for 2024-12-31 at 09:30 am with Alina Shahzad.\n Selected Services : Threading",
                              style: TextStyle(
                                fontSize: width * 0.036,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          )
        ],
      ),
    ));
  }
}
