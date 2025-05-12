import 'package:beautybazzle/model/addservice/servic_data.dart';

import 'package:flutter/material.dart';

class ServicesCategriesScreen extends StatefulWidget {
  const ServicesCategriesScreen({super.key});

  @override
  State<ServicesCategriesScreen> createState() =>
      _ServicesCategriesScreenState();
}

class _ServicesCategriesScreenState extends State<ServicesCategriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Services Categories",
            style: TextStyle(color: Colors.black),
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: "Hair"),
              Tab(text: "Skin"),
              Tab(text: "Makeup"),
              Tab(text: "Nails"),
              Tab(text: "Body"),
              Tab(text: "Bridal"),
            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(
            7,
            (tabIndex) => TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
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
              child: ListView.builder(
                itemCount: UserModel5.mylist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SalonAppointmentScreen(salon:),
                        //     ));
                      },
                      child: Container(
                        height: height * 0.12,
                        width: width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: width * 0.002,
                          ),
                        ),
                        child: Center(
                          child: ListTile(
                            leading: Container(
                              height: height * 0.07,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/salon.jpeg"),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            title: Text(
                              UserModel5.mylist[index].name!,
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              UserModel5.mylist[index].Description1!,
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
