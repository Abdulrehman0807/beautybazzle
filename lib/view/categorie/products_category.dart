import 'package:beautybazzle/view/categorie/beauty_product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 6, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black, // Set the back (pop) icon color to black
          ),
          title: const Text(
            "Product Categories",
            style: TextStyle(color: Colors.black),
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.black, // Active tab text color
            unselectedLabelColor: Colors.black54, // Inactive tab text color
            tabs: [
              Tab(text: "Cream"),
              Tab(text: "Facial"),
              Tab(text: "Mask"),
              Tab(text: "Losion"),
              Tab(text: "Deal Box"),
              Tab(text: "Makeup"),
            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(6, (index) {
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BeautyProductScreen(),
                    ));
              },
              child: Container(
                height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.black12, width: width * 0.002),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: ListTile(
                    leading: Container(
                      height: height * 0.07,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/product.jpg"),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    title: Text(
                      "Fizza Beauty Cream",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "A nourishing cream that brightens, hydrates, and smooths skin for a radiant, even-toned glow.",
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
    );
  }
}
