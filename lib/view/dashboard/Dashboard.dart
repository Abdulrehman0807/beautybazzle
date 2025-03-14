import 'package:beautybazzle/model/addproduct/addproduct.dart';
import 'package:beautybazzle/model/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/categorie/beauty_product.dart';
import 'package:beautybazzle/view/orders/cart.dart';
import 'package:beautybazzle/view/categorie/home_care_service.dart';
import 'package:beautybazzle/view/notification/notification.dart';
import 'package:beautybazzle/view/categorie/products_category.dart';
import 'package:beautybazzle/view/profiles/profile.dart';
import 'package:beautybazzle/view/categorie/salon.dart';
import 'package:beautybazzle/view/categorie/salon_category.dart';
import 'package:beautybazzle/view/categorie/services_categraties.dart';
import 'package:beautybazzle/view/categorie/specialists.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedCity = "Select a City";

  final List<String> cities = [
    "Karachi",
    "Lahore",
    "Islamabad",
    "Rawalpindi",
    "Peshawar",
    "Quetta",
    "Multan",
    "Faisalabad",
    "Hyderabad",
    "Sialkot",
    "Gujranwala",
    "Bahawalpur",
  ];

  void _showCitySelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Select a City",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[200]),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cities[index]),
                    onTap: () {
                      setState(() {
                        selectedCity = cities[index];
                      });
                      Navigator.pop(context); // Close the bottom sheet
                      // Add functionality here to filter services based on the selected city
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  int currentPageIndex = 0;
  int _currentIndex = 0;

  final List<Widget> _carouselItems = [
    Container(
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("images/OIP.jpg")),
          borderRadius: BorderRadius.circular(20)),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("images/OIP1.jpg")),
          borderRadius: BorderRadius.circular(20)),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("images/OIP2.jpg")),
          borderRadius: BorderRadius.circular(20)),
    ),
  ];
  double rating = 3.0;
  final Set<int> favoriteProductIndices = {};
  final Set<int> favoriteSalonIndices = {};
  final Set<int> favoriteSpecialistIndices = {};
  final Set<int> favoriteHomeCareSpecialistIndices = {};

// Favorite Toggle Method
  void toggleFavorite(Set<int> favoriteSet, int index) {
    bool isFavorite =
        favoriteSet.contains(index); // Check if the item is already favorited

    setState(() {
      if (isFavorite) {
        favoriteSet.remove(index); // Remove from favorites if already added
      } else {
        favoriteSet.add(index); // Add to favorites if not already added
      }
    });

    // Show the toast message based on whether the item was added or removed
    Fluttertoast.showToast(
      msg: isFavorite
          ? "Removed from favorites"
          : "Successfully added to favorites", // Conditional message
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.pink[200],
      textColor: Colors.black,
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    _fetchSalonsAndProducts();
  }

  Future<void> _fetchSalonsAndProducts() async {
    try {
      // Fetch all salons
      QuerySnapshot salonSnapshot = await _firestore.collection('salons').get();

      for (var salonDoc in salonSnapshot.docs) {
        String salonId = salonDoc.id;

        // Fetch products for the current salon
        QuerySnapshot productSnapshot = await _firestore
            .collection('products')
            .where('SalonId', isEqualTo: salonId)
            .get();

        if (productSnapshot.docs.isNotEmpty) {
          // Get the first product of the salon
          var firstProductData =
              productSnapshot.docs.first.data() as Map<String, dynamic>;
          ProductModel firstProduct = ProductModel.fromMap(firstProductData);

          // Add the first product to the product list
          setState(() {
            productList.add(firstProduct);
          });
        }
      }
    } catch (e) {
      print("Error fetching salons and products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: height * 0.69,
                width: width,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Best Offers",
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.22,
                      width: width,
                      child: CarouselSlider(
                        items: _carouselItems,
                        options: CarouselOptions(
                          height: height * 0.21,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _carouselItems.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _currentIndex = entry.key;
                          }),
                          child: Container(
                            width: width * 0.02,
                            height: height * 0.02,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      height: height * 0.055,
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Services",
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.12,
                      width: width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: UserModel
                            .mylist.length, // Use the length of your list
                        itemBuilder: (context, index) {
                          // Access each item in the list using UserModel.mylist[index]
                          final user = UserModel.mylist[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ServicesCategriesScreen(),
                                    ));
                              },
                              child: Container(
                                height: height * 0.1,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor:
                                          Color.fromARGB(255, 250, 199, 217),
                                      child: Icon(
                                        user.icon!,
                                        color: Colors.black,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                      ),
                                    ),
                                    Text(
                                      user.name!,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.028,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    Container(
                      height: height * 0.065,
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Specialist",
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SpecialistsScreen(),
                                  ));
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.2,
                              child: Row(
                                children: [
                                  Text(
                                    "View More",
                                    style: TextStyle(
                                        fontSize: width * 0.026,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: width * 0.026,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.22,
                      width: width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(),
                                      ));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: height * 0.2,
                                      width: width * 0.34,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                AssetImage(StaticData.myDp),
                                          ),
                                          Container(
                                            height: height * 0.06,
                                            width: width * 0.4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      "Alena Shahzad",
                                                      style: TextStyle(
                                                        fontSize: width * 0.032,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                      RatingStars(
                                                        value: rating,
                                                        onValueChanged:
                                                            (newRating) {},
                                                        starCount:
                                                            5, // Number of stars
                                                        starSize:
                                                            12, // Size of the stars
                                                        starColor:
                                                            Color.fromARGB(255,
                                                                241, 134, 170),
                                                        valueLabelColor:
                                                            Color.fromRGBO(240,
                                                                134, 169, 1),
                                                        starSpacing:
                                                            2, // Space between the stars
                                                        valueLabelVisibility:
                                                            false,
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.03,
                                                      ),
                                                      Text(
                                                        '$rating',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .black, // Adjust color as needed
                                                        ),
                                                      ),
                                                    ]))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 110.0, top: 8),
                                      child: GestureDetector(
                                        onTap: () => toggleFavorite(
                                            favoriteSpecialistIndices,
                                            index), // Pass the correct favorite set for specialists
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 18,
                                          child: Icon(
                                            favoriteSpecialistIndices.contains(
                                                    index) // Use favoriteSpecialistIndices to check if the item is in favorites
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: favoriteSpecialistIndices
                                                    .contains(index)
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nearby Salons",
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SalonCategoryScreen(),
                                  ));
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.2,
                              child: Row(
                                children: [
                                  Text(
                                    "View More",
                                    style: TextStyle(
                                        fontSize: width * 0.026,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: width * 0.026,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: height * 0.3,
                        width: width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SalonScreen(),
                                        ));
                                  },
                                  child: Container(
                                    height: height * 0.3,
                                    width: width * 0.75,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "images/salon.jpeg")),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.7,
                                          height: height * 0.1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Ajoba BeautyPalour",
                                                      style: TextStyle(
                                                        fontSize: width * 0.05,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => toggleFavorite(
                                                          favoriteSalonIndices,
                                                          index), // Pass the correct favorite set for salons
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 15,
                                                        child: Icon(
                                                          favoriteSalonIndices
                                                                  .contains(
                                                                      index) // Use favoriteSalonIndices to check if the item is in favorites
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          color:
                                                              favoriteSalonIndices
                                                                      .contains(
                                                                          index)
                                                                  ? Colors.red
                                                                  : Colors.grey,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  "Ghoeer town bahwalpur ",
                                                  style: TextStyle(
                                                    fontSize: width * 0.04,
                                                    fontWeight: FontWeight.w400,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                    RatingStars(
                                                      value: rating,
                                                      onValueChanged:
                                                          (newRating) {},
                                                      starCount:
                                                          5, 
                                                      starSize:
                                                          12, 
                                                      starColor: Color.fromARGB(
                                                          255, 241, 134, 170),
                                                      valueLabelColor:
                                                          Color.fromRGBO(
                                                              240, 134, 169, 1),
                                                      starSpacing:
                                                          2, 
                                                      valueLabelVisibility:
                                                          false,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.03,
                                                    ),
                                                    Text(
                                                      '$rating',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .black, // Adjust color as needed
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.4,
                                                    ),
                                                  ]))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductScreen(),
                                  ));
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.2,
                              child: Row(
                                children: [
                                  Text(
                                    "View More",
                                    style: TextStyle(
                                        fontSize: width * 0.026,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: width * 0.026,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.25,
                      width: width,
                      child:

                          // ListView.builder(
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: 7,
                          //   itemBuilder: (context, index) {
                          //     return Padding(
                          //       padding: const EdgeInsets.all(8),
                          //       child: GestureDetector(
                          //         onTap: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     BeautyProductScreen(),
                          //               ));
                          //         },
                          //         child: Card(
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(10)),
                          //           elevation: 2,
                          //           child: Container(
                          //             height: height * 0.26,
                          //             width: width * 0.35,
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceEvenly,
                          //               children: [
                          //                 Container(
                          //                   width: width * 0.33,
                          //                   height: height * 0.13,
                          //                   decoration: BoxDecoration(
                          //                     border: Border.all(
                          //                         color: Colors.black12),
                          //                     borderRadius:
                          //                         BorderRadius.circular(15),
                          //                     image: DecorationImage(
                          //                         fit: BoxFit.cover,
                          //                         image: AssetImage(
                          //                             "images/product.jpg")),
                          //                   ),
                          //                 ),
                          //                 Container(
                          //                   height: height * 0.09,
                          //                   width: width * 0.3,
                          //                   // color: Colors.blue,
                          //                   child: Column(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceEvenly,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         child: Text(
                          //                           "Fizza Beauty Cream",
                          //                           style: TextStyle(
                          //                             fontSize: width * 0.033,
                          //                             fontWeight: FontWeight.w500,
                          //                             overflow:
                          //                                 TextOverflow.ellipsis,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                       Row(
                          //                         children: [
                          //                           SizedBox(
                          //                             child: RichText(
                          //                                 text:
                          //                                     TextSpan(children: [
                          //                               TextSpan(
                          //                                   text: "\$",
                          //                                   style: TextStyle(
                          //                                       color: Colors.red,
                          //                                       fontSize:
                          //                                           width * 0.032,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .w400)),
                          //                               TextSpan(
                          //                                   text: "600",
                          //                                   style: TextStyle(
                          //                                       color: Colors.red,
                          //                                       fontSize:
                          //                                           width * 0.035,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .w400))
                          //                             ])),
                          //                           ),
                          //                           SizedBox(
                          //                             width: width * 0.148,
                          //                           ),
                          //                           GestureDetector(
                          //                             onTap: () => toggleFavorite(
                          //                                 favoriteProductIndices,
                          //                                 index), // Pass the correct favorite set for products
                          //                             child: CircleAvatar(
                          //                               backgroundColor:
                          //                                   Colors.white,
                          //                               radius: 13,
                          //                               child: Icon(
                          //                                 favoriteProductIndices
                          //                                         .contains(
                          //                                             index) // Use favoriteProductIndices to check if the item is in favorites
                          //                                     ? Icons
                          //                                         .favorite // Filled heart if favorited
                          //                                     : Icons
                          //                                         .favorite_border, // Outline heart if not favorited
                          //                                 color: favoriteProductIndices
                          //                                         .contains(
                          //                                             index) // Red if favorited, grey if not
                          //                                     ? Colors.red
                          //                                     : Colors.grey,
                          //                                 size: 19,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       Center(
                          //                         child: Row(
                          //                           children: [
                          //                             RatingStars(
                          //                               value: rating,
                          //                               onValueChanged:
                          //                                   (newRating) {},
                          //                               starCount:
                          //                                   1, // Number of stars
                          //                               starSize:
                          //                                   13, // Size of the stars
                          //                               starColor: Color.fromARGB(
                          //                                   255, 241, 134, 170),
                          //                               valueLabelColor:
                          //                                   Color.fromRGBO(
                          //                                       240, 134, 169, 1),
                          //                               starSpacing:
                          //                                   2, // Space between the stars
                          //                               valueLabelVisibility:
                          //                                   false,
                          //                             ),
                          //                             SizedBox(
                          //                               width: width * 0.01,
                          //                             ),
                          //                             RichText(
                          //                                 text:
                          //                                     TextSpan(children: [
                          //                               TextSpan(
                          //                                   text: '$rating',
                          //                                   style: TextStyle(
                          //                                       color:
                          //                                           Colors.black,
                          //                                       fontSize:
                          //                                           width * 0.032,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .w500)),
                          //                               TextSpan(
                          //                                   text: "  (324)",
                          //                                   style: TextStyle(
                          //                                       color:
                          //                                           Colors.black,
                          //                                       fontSize:
                          //                                           width * 0.032,
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .w400))
                          //                             ])),
                          //                             SizedBox(
                          //                               width: width * 0.04,
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // )
                          ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          ProductModel product = productList[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the details screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BeautyProductScreen(product: product),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(product.productPic ?? ''),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  product.productName ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: height * 0.23,
                        width: width * 0.93,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/OIP3.jpg")),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 8,
                                right: 8,
                                child: Text(
                                  "Ads",
                                  style: TextStyle(color: Colors.black),
                                )),
                            Container(
                              height: height * 0.25,
                              width: width * 0.95,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      height: height * 0.065,
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pro Care at Home",
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeCareServiceScreen(),
                                  ));
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.2,
                              child: Row(
                                children: [
                                  Text(
                                    "View More",
                                    style: TextStyle(
                                        fontSize: width * 0.026,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: width * 0.026,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.22,
                      width: width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(),
                                      ));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: height * 0.2,
                                      width: width * 0.34,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:
                                                AssetImage(StaticData.myDp),
                                          ),
                                          Container(
                                            height: height * 0.06,
                                            width: width * 0.3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      "Alena Shahzad",
                                                      style: TextStyle(
                                                        fontSize: width * 0.032,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                      RatingStars(
                                                        value: rating,
                                                        onValueChanged:
                                                            (newRating) {},
                                                        starCount:
                                                            5, // Number of stars
                                                        starSize:
                                                            12, // Size of the stars
                                                        starColor:
                                                            Color.fromARGB(255,
                                                                241, 134, 170),
                                                        valueLabelColor:
                                                            Color.fromRGBO(240,
                                                                134, 169, 1),
                                                        starSpacing:
                                                            2, // Space between the stars
                                                        valueLabelVisibility:
                                                            false,
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.03,
                                                      ),
                                                      Text(
                                                        '$rating',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .black, // Adjust color as needed
                                                        ),
                                                      ),
                                                    ]))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 110.0, top: 8),
                                      child: GestureDetector(
                                        onTap: () => toggleFavorite(
                                            favoriteHomeCareSpecialistIndices,
                                            index), // Pass the correct favorite set for home care specialists
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 18,
                                          child: Icon(
                                            favoriteHomeCareSpecialistIndices
                                                    .contains(
                                                        index) // Use favoriteHomeCareSpecialistIndices to check if the item is in favorites
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:
                                                favoriteHomeCareSpecialistIndices
                                                        .contains(index)
                                                    ? Colors.red
                                                    : Colors.grey,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
              ),
            ),
            Container(
              height: height * 0.23,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.045,
                  ),
                  ListTile(
                    title: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Hello, ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.w300)),
                      TextSpan(
                          text: "${StaticData.userModel!.name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w600))
                    ])),
                    subtitle: Text(
                      "Welcome to ${StaticData.name}",
                      style: TextStyle(fontSize: width * 0.035),
                    ),
                    trailing: Container(
                      height: height * 0.05,
                      width: width * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(),
                                  ));
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.shopping_bag,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationScreen(),
                                  ));
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.notifications,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height * 0.05,
                        width: width * 0.75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black,
                            )),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: height * 0.015),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 0.01),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              size: width * 0.06,
                              color: Colors.grey,
                            ),
                            hintText: 'Search Salon Specialist, products',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Container(
                        height: height * 0.045,
                        width: width * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.filter,
                            size: width * 0.05,
                            color: Colors.black,
                          ),
                          onPressed: _showCitySelector,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
