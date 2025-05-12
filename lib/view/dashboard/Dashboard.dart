import 'dart:async';
import 'package:beautybazzle/model/addproduct/addproduct.dart';
import 'package:beautybazzle/model/addsalon/addsalon.dart';
import 'package:beautybazzle/model/addservice/servic_data.dart';
import 'package:beautybazzle/model/signup_login/signup_model.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/categorie/beauty_product.dart';
import 'package:beautybazzle/view/categorie/salons.dart';
import 'package:beautybazzle/view/orders/cart.dart';
import 'package:beautybazzle/view/notification/notification.dart';
import 'package:beautybazzle/view/categorie/products_category.dart';
import 'package:beautybazzle/view/profiles/profile.dart';
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
  int _currentIndex = 0;
  double rating = 3.0;
  final Set<int> favoriteProductIndices = {};
  final Set<int> favoriteSalonIndices = {};
  final Set<int> favoriteSpecialistIndices = {};
  final Set<int> favoriteHomeCareSpecialistIndices = {};

  // Cached data
  List<UserModels>? _cachedSpecialists;
  List<SalonModel>? _cachedSalons;
  List<ProductModel>? _cachedProducts;
  List<UserModels>? _cachedHomeCareSpecialists;

  // Stream subscriptions
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _initializeStreams();
    _subscriptions.add(FirebaseFirestore.instance
        .collection('Users')
        .snapshots()
        .listen((snapshot) {
      // Handle data
    }));

    _subscriptions.add(FirebaseFirestore.instance
        .collection('salons')
        .snapshots()
        .listen((snapshot) {
      // Handle data
    }));

    _subscriptions.add(FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((snapshot) {
      // Handle data
    }));
  }

  @override
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    super.dispose();
    _specialistStream?.cancel();
    _salonStream?.cancel();
    _productStream?.cancel();
    _homeCareStream?.cancel();
  }

  // 1. Declare your stream subscriptions at the class level
  StreamSubscription<QuerySnapshot>? _specialistStream;
  StreamSubscription<QuerySnapshot>? _salonStream;
  StreamSubscription<QuerySnapshot>? _productStream;
  StreamSubscription<QuerySnapshot>? _homeCareStream;

  void _initializeStreams() {
    // Specialist stream
    _specialistStream = FirebaseFirestore.instance
        .collection('Users')
        .limit(10)
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          _cachedSpecialists = snapshot.docs
              .map((doc) => UserModels.fromMap(doc.data()))
              .toList();
        });
      }
    });

    // Salon stream
    _salonStream = FirebaseFirestore.instance
        .collection('salons')
        .limit(10)
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          _cachedSalons = snapshot.docs
              .map((doc) => SalonModel.fromMap(doc.data()))
              .toList();
        });
      }
    });

    // Product stream
    _productStream = FirebaseFirestore.instance
        .collection('products')
        .limit(10)
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          _cachedProducts = snapshot.docs
              .map((doc) => ProductModel.fromMap(doc.data()))
              .toList();
        });
      }
    });

    // Home Care stream
    _homeCareStream = FirebaseFirestore.instance
        .collection('Users')
        .limit(10)
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          _cachedHomeCareSpecialists = snapshot.docs
              .map((doc) => UserModels.fromMap(doc.data()))
              .toList();
        });
      }
    });
  }

  void toggleFavorite(Set<int> favoriteSet, int index) {
    setState(() {
      if (favoriteSet.contains(index)) {
        favoriteSet.remove(index);
        Fluttertoast.showToast(msg: "Removed from favorites");
      } else {
        favoriteSet.add(index);
        Fluttertoast.showToast(msg: "Successfully added to favorites");
      }
    });
  }

  void _refreshData() {
    setState(() {
      _cachedSpecialists = null;
      _cachedSalons = null;
      _cachedProducts = null;
      _cachedHomeCareSpecialists = null;
    });
    _initializeStreams();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _refreshData(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header Section
              _buildHeaderSection(height, width),

              // Carousel Section
              _buildCarouselSection(height, width),

              // Services Section
              _buildServicesSection(height, width),

              // Specialists Section
              _buildSpecialistsSection(height, width),

              // Salons Section
              _buildSalonsSection(height, width),

              // Products Section
              _buildProductsSection(height, width),

              // Home Care Section
              _buildHomeCareSection(height, width),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(double height, double width) {
    return Container(
      height: height * 0.23,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: Column(
        children: [
          SizedBox(height: height * 0.045),
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_bag),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: height * 0.015),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 0.01),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 90, 87, 87), width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: width * 0.06,
                        color: Colors.grey,
                      ),
                      hintText: 'Search Salon Specialist, products',
                      hintStyle: const TextStyle(
                          color: Colors.grey, overflow: TextOverflow.ellipsis),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
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
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSection(double height, double width) {
    final carouselItems = [
      _buildCarouselItem("images/OIP.jpg"),
      _buildCarouselItem("images/OIP1.jpg"),
      _buildCarouselItem("images/OIP2.jpg"),
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Best Offers", style: TextStyle(fontSize: width * 0.05)),
            ],
          ),
        ),
        CarouselSlider(
          items: carouselItems,
          options: CarouselOptions(
            height: height * 0.21,
            viewportFraction: 0.8,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselItems.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key ? Colors.black : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  Widget _buildServicesSection(double height, double width) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Services", style: TextStyle(fontSize: width * 0.05)),
            ],
          ),
        ),
        Container(
          height: height * 0.12,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: UserModel.mylist.length,
            itemBuilder: (context, index) {
              final user = UserModel.mylist[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServicesCategriesScreen()),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Color.fromARGB(255, 250, 199, 217),
                        child: Icon(user.icon!, color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Text(user.name!,
                          style: TextStyle(fontSize: width * 0.028)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialistsSection(double height, double width) {
    if (_cachedSpecialists == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (_cachedSpecialists!.isEmpty) {
      return Center(child: Text('No Specialists available'));
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Specialist", style: TextStyle(fontSize: width * 0.05)),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpecialistsScreen()),
                ),
                child: Text("View More"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _cachedSpecialists!.length,
            itemBuilder: (context, index) {
              final model = _cachedSpecialists![index];
              return _buildSpecialistCard(model, index, height, width);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialistCard(
      UserModels model, int index, double height, double width) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            model1: model,
                          )),
                );
              },
              child: Container(
                width: width * 0.34,
                height: height * 0.24,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(model.ProfilePicture ?? ''),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(model.name ?? 'No Name',
                        style: TextStyle(fontSize: width * 0.032)),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    RatingStars(
                      value: rating,
                      starCount: 5,
                      starSize: 12,
                      starColor: Color.fromARGB(255, 241, 134, 170),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: () => toggleFavorite(favoriteSpecialistIndices, index),
                child: Icon(
                  favoriteSpecialistIndices.contains(index)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favoriteSpecialistIndices.contains(index)
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalonsSection(double height, double width) {
    if (_cachedSalons == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (_cachedSalons!.isEmpty) {
      return Center(child: Text('No Salons available'));
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nearby Salons", style: TextStyle(fontSize: width * 0.05)),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalonCategoryScreen()),
                ),
                child: Text("View More"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _cachedSalons!.length,
            itemBuilder: (context, index) {
              final model = _cachedSalons![index];
              return _buildSalonCard(model, index, height, width);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSalonCard(
      SalonModel model, int index, double height, double width) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SalonsScreen(model: model)),
            );
          },
          child: Container(
            height: height * 0.3,
            width: width * 0.75,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(model.SalonPicture ?? ''),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.7,
                  height: height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                model.SalonName ?? '',
                                style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  toggleFavorite(favoriteSalonIndices, index),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Icon(
                                  favoriteSalonIndices.contains(index)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoriteSalonIndices.contains(index)
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
                          model.salonDescription ?? '',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingStars(
                              value: rating,
                              starCount: 5,
                              starSize: 12,
                              starColor: Color.fromARGB(255, 241, 134, 170),
                            ),
                            SizedBox(width: width * 0.03),
                            Text(
                              '$rating',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSection(double height, double width) {
    if (_cachedProducts == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (_cachedProducts!.isEmpty) {
      return Center(child: Text('No Products available'));
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Products", style: TextStyle(fontSize: width * 0.05)),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductScreen()),
                ),
                child: Text("View More"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _cachedProducts!.length,
            itemBuilder: (context, index) {
              final model = _cachedProducts![index];
              return _buildProductCard(model, index, height, width);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
      ProductModel model, int index, double height, double width) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BeautyProductScreen(product: model),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Container(
            height: height * 0.26,
            width: width * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.33,
                  height: height * 0.13,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(model.productPic!),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.09,
                  width: width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${model.productName}",
                        style: TextStyle(
                          fontSize: width * 0.033,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "\$",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: width * 0.032,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "${model.productPrice}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () =>
                                toggleFavorite(favoriteProductIndices, index),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 13,
                              child: Icon(
                                favoriteProductIndices.contains(index)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteProductIndices.contains(index)
                                    ? Colors.red
                                    : Colors.grey,
                                size: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RatingStars(
                            value: rating,
                            starCount: 3,
                            starSize: 13,
                            starColor: Color.fromARGB(255, 241, 134, 170),
                          ),
                          SizedBox(width: width * 0.01),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeCareSection(double height, double width) {
    if (_cachedHomeCareSpecialists == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (_cachedHomeCareSpecialists!.isEmpty) {
      return Center(child: Text('No Home Care Specialists available'));
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pro Care at Home",
                  style: TextStyle(fontSize: width * 0.05)),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpecialistsScreen()),
                ),
                child: Text("View More"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _cachedHomeCareSpecialists!.length,
            itemBuilder: (context, index) {
              final model = _cachedHomeCareSpecialists![index];
              return _buildHomeCareSpecialistCard(model, index, height, width);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomeCareSpecialistCard(
      UserModels model, int index, double height, double width) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(model1: model),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                height: height * 0.22,
                width: width * 0.34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(model.ProfilePicture ?? ''),
                    ),
                    Container(
                      height: height * 0.06,
                      width: width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Center(
                              child: Text(
                                model.name ?? 'No Name',
                                style: TextStyle(
                                  fontSize: width * 0.032,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingStars(
                                  value: rating,
                                  starCount: 5,
                                  starSize: 12,
                                  starColor: Color.fromARGB(255, 241, 134, 170),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () =>
                      toggleFavorite(favoriteHomeCareSpecialistIndices, index),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(
                      favoriteHomeCareSpecialistIndices.contains(index)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteHomeCareSpecialistIndices.contains(index)
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
  }

  void _showCitySelector() {
    final cities = [
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

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Select a City",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[200],
                ),
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
                      setState(() => selectedCity = cities[index]);
                      Navigator.pop(context);
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
}
