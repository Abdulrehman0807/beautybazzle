import 'package:beautybazzle/utiils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Fizza Beauty Cream",
      "dp": "images/product.jpg",
      "description": "Face Serum",
      "rating": 4.5
    },
    {
      "name": "Fizza Beauty Cream",
      "dp": "images/product.jpg",
      "description": "Hair Oil",
      "rating": 4.0
    },
    {
      "name": "Fizza Beauty Cream",
      "dp": "images/product.jpg",
      "description": "Lipstick",
      "rating": 4.2
    },
    {
      "name": "Product 4",
      "dp": "images/product.jpg",
      "description": "Eyeliner",
      "rating": 3.8
    },
  ];

  final List<Map<String, dynamic>> salons = [
    {
      "name": "Ajoba BeautyPalour",
      "dp": "images/salon.jpeg",
      "description": "Premium Hair Salon",
      "rating": 4.8
    },
    {
      "name": "Ajoba BeautyPalour",
      "dp": "images/salon.jpeg",
      "description": "Beauty & Spa",
      "rating": 4.2
    },
    {
      "name": "Ajoba BeautyPalour",
      "dp": "images/salon.jpeg",
      "description": "Classic Hair Care",
      "rating": 4.0
    },
  ];

  final List<Map<String, dynamic>> specialists = [
    {
      "name": "Alina Shahzad",
      "dp": StaticData.myDp,
      "description": "Hair Specialist",
      "rating": 4.6
    },
    {
      "name": "Sarah Imran",
      "dp": StaticData.myDp,
      "description": "Makeup Artist",
      "rating": 4.7
    },
    {
      "name": "Bahktwar Rehman",
      "dp": StaticData.myDp,
      "description": "Nail Technician",
      "rating": 4.3
    },
  ];

  final Set<int> favoriteProductIndices = {};
  final Set<int> favoriteSalonIndices = {};
  final Set<int> favoriteSpecialistIndices = {};

  void toggleFavorite(
      List<Map<String, dynamic>> items, Set<int> favoriteSet, int index) {
    setState(() {
      if (favoriteSet.contains(index)) {
        favoriteSet.remove(index);
        items.removeAt(index); // Remove the item if unfavorited
      } else {
        favoriteSet.add(index); // Add the index to the favorites
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Favorites",
            style: TextStyle(color: Colors.black),
          ),
          bottom: const TabBar(
            isScrollable: false,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: "Specialists"),
              Tab(text: "Salons"),
              Tab(text: "Products"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildFavoriteList(
              specialists,
              favoriteSpecialistIndices,
              (index) =>
                  toggleFavorite(specialists, favoriteSpecialistIndices, index),
              height,
              width,
            ),
            buildFavoriteList(
              salons,
              favoriteSalonIndices,
              (index) => toggleFavorite(salons, favoriteSalonIndices, index),
              height,
              width,
            ),
            buildFavoriteList(
              products,
              favoriteProductIndices,
              (index) =>
                  toggleFavorite(products, favoriteProductIndices, index),
              height,
              width,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavoriteList(
    List<Map<String, dynamic>> items,
    Set<int> favorites,
    Function(int) toggleFavorite,
    double height,
    double width,
  ) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return TweenAnimationBuilder(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: height * 0.13,
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(item["dp"]),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item["name"],
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item["description"],
                            style: TextStyle(
                              fontSize: width * 0.032,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          RatingStars(
                            value: item["rating"],
                            onValueChanged: (newRating) {},
                            starCount: 5,
                            starSize: 15,
                            starColor: const Color(0xFFF186AA),
                            starSpacing: 2,
                            valueLabelVisibility: false,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => toggleFavorite(index),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: Icon(
                          favorites.contains(index)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favorites.contains(index)
                              ? Colors.red
                              : Colors.grey,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
