import 'package:beautybazzle/view/categorie/salon.dart';
import 'package:flutter/material.dart';

class SalonCategoryScreen extends StatefulWidget {
  const SalonCategoryScreen({super.key});

  @override
  State<SalonCategoryScreen> createState() => _SalonCategoryScreenState();
}

class _SalonCategoryScreenState extends State<SalonCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black, // Set the back (pop) icon color to black
          ),
          title: const Text(
            "Salons Categroies",
            style: TextStyle(color: Colors.black),
          ),
          bottom: const TabBar(
            isScrollable: false,
            labelColor: Colors.black, // Active tab text color
            unselectedLabelColor: Colors.black54, // Makes the TabBar scrollable
            tabs: [
              Tab(
                text: "Nearby",
              ),
              Tab(text: "OverAll"),
            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(2, (index) {
            return TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 50 * (1 - value)), // Slide-in effect
                    child: child,
                  ),
                );
              },
              child: _buildTabContent(height, width),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabContent(double height, double width) {
    return Container(
      height: height * 0.7,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonScreen(),
                    ));
              },
              child: Container(
                height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12, width: width * 0.002)),
                child: Center(
                  child: ListTile(
                    leading: Container(
                      height: height * 0.07,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("images/salon.jpeg")),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    title: Text(
                      "Ajoba BeautyPalour",
                      style: TextStyle(
                          fontSize: width * 0.04, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "Enhancing your natural beauty with personalized care and expertise at Ajoba Beauty Parlor.",
                      style: TextStyle(
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
