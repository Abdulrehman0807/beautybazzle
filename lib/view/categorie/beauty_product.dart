import 'package:beautybazzle/controller/editprofilecontroller.dart';
import 'package:beautybazzle/model/addproduct.dart';
import 'package:beautybazzle/model/servic_data.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:beautybazzle/view/categorie/products_category.dart';
import 'package:beautybazzle/view/orders/check_out.dart';
import 'package:beautybazzle/view/profiles/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class BeautyProductScreen extends StatefulWidget {
  final ProductModel product;

  const BeautyProductScreen({required this.product, Key? key})
      : super(key: key);

  @override
  State<BeautyProductScreen> createState() => _BeautyProductScreenState();
}

class _BeautyProductScreenState extends State<BeautyProductScreen>
    with SingleTickerProviderStateMixin {
  double rating = 4.0;
  PageController controller = PageController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GetBuilder<ProfileController>(builder: (obj) {
      return DefaultTabController(
        length: 1,
        child: Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Center(
                        child: Stack(
                          children: [
                            Image.network(widget.product.productPic ?? ''),
                            // Center(
                            //   child:

                            //   Container(
                            //     decoration: BoxDecoration(

                            //   image:
                            // obj.usermodel!.SalonPicture != ""
                            //       ? DecorationImage(
                            //           fit: BoxFit.cover,
                            //           image: NetworkImage(StaticData
                            //               .userModel!.SalonPicture),
                            //         )
                            //       : null,
                            // ),
                            // child: obj.usermodel!.SalonPicture == ""
                            //     ? CircleAvatar(
                            //         radius: 100,
                            //         backgroundColor: Colors.pink[200],
                            //         child: const Icon(
                            //           Icons.camera_alt,
                            //           size: 50,
                            //           color: Colors.white,
                            //         ),
                            //       )

                            //     : null,

                            //     )

                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    floating: true,
                    pinned: false,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SlideTransition(
                        position: _slideAnimation,
                        child: _buildProductDetails(context, height, width),
                      ),
                    ]),
                  ),
                ],
              ),
              _buildBottomBar(context, height, width),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProductDetails(
      BuildContext context, double height, double width) {
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        Container(
          height: height * 0.04,
          width: width * 0.93,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.productName ?? '',
                style: TextStyle(
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  RatingStars(
                    value: rating,
                    starCount: 5,
                    starSize: 16,
                    starColor: const Color.fromARGB(255, 241, 134, 170),
                    valueLabelVisibility: false,
                  ),
                  SizedBox(width: width * 0.01),
                  Text(
                    '$rating',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: height * 0.05,
          width: width * 0.93,
          child: Text(
            "Fizza Beauty Cream",
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _buildSellerCard(height, width),
        SizedBox(height: height * 0.01),
        _buildProductDetailsSection(height, width),
        _buildRelatedProductsTab(height, width),
      ],
    );
  }

  Widget _buildSellerCard(double height, double width) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: height * 0.085,
        width: width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage("images/girl.jpg"),
          ),
          title: Text(
            "${StaticData.userModel!.name}",
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            "Beauty Specialist",
            style: TextStyle(
              fontSize: width * 0.032,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
            },
            child: Container(
              height: height * 0.04,
              width: width * 0.2,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "View Profile",
                  style: TextStyle(fontSize: width * 0.03, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetailsSection(double height, double width) {
    return Container(
      height: height * 0.15,
      child: ListTile(
        title: Text(
          "Product Details",
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          widget.product.productDescription ?? 'No Description',
          // "Fizza Beauty Cream nourishes and hydrates for a radiant, even-toned complexion, reducing dark spots and fine lines with its lightweight, non-greasy formula. Suitable for all skin types, it leaves skin soft and glowing all day.",
          style: TextStyle(
            fontSize: width * 0.036,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildRelatedProductsTab(double height, double width) {
    return

        // Container(
        //   height: UserModel1.mylist.length * height * 0.13,
        //   width: width,
        //   child: Column(
        //     children: UserModel1.mylist.map((item) {
        //       return Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 4.0),
        //         child: GestureDetector(
        //           onTap: () {
        //             // Navigator.push(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //       builder: (context) => BeautyProductScreen(),
        //             //     ));
        //           },
        //           child: Container(
        //             height: height * 0.1,
        //             width: width,
        //             decoration: BoxDecoration(
        //               border:
        //                   Border.all(color: Colors.black12, width: width * 0.002),
        //             ),
        //             child: ListTile(
        //               leading: Container(
        //                 height: height * 0.07,
        //                 width: width * 0.15,
        //                 decoration: BoxDecoration(
        //                   image: const DecorationImage(
        //                     fit: BoxFit.cover,
        //                     image: AssetImage("images/product.jpg"),
        //                   ),
        //                   borderRadius: BorderRadius.circular(10),
        //                 ),
        //               ),
        //               title: Text(
        //                 "Fizza Beauty Cream",
        //                 style: TextStyle(
        //                   fontSize: width * 0.04,
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //               ),
        //               subtitle: Text(
        //                 "A nourishing cream that brightens, hydrates, and smooths skin for a radiant, even-toned glow.",
        //                 style: TextStyle(
        //                   fontSize: width * 0.03,
        //                   fontWeight: FontWeight.w400,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       );
        //     }).toList(),
        //   ),
        Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('products')
            .where('SalonId',
                isEqualTo: widget.product.userId) // Assuming userId is salonId
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No other products available'));
          }

          var products = snapshot.data!.docs
              .map((doc) =>
                  ProductModel.fromMap(doc.data() as Map<String, dynamic>))
              .where((product) =>
                  product.productId !=
                  widget.product.productId) // Exclude the current product
              .toList();

          return Container(
            height:
                products.length * height * 0.13, // Adjust height dynamically
            width: width,
            child: Column(
              children: products.map((product) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the details screen for the selected product
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: height * 0.1,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black12, width: width * 0.002),
                      ),
                      child: ListTile(
                        leading: Container(
                          height: height * 0.07,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(product.productPic ?? ''),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        title: Text(
                          product.productName ?? 'No Name',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          product.productDescription ?? 'No Description',
                          style: TextStyle(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, double height, double width) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: height * 0.1,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: width * 0.005),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPriceSection(height, width),
            _buildActionButton(height, width, "Buy Now", Colors.white),
            _buildActionButton1(
                height, width, "Add to Cart", Colors.pink[200]!),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(double height, double width) {
    return Container(
      height: height * 0.07,
      width: width * 0.27,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Price",
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            'Price: \$${widget.product.productPrice ?? 'N/A'}',
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(double height, double width, String label,
      [Color? backgroundColor]) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutScreen(),
            ));
      },
      child: Container(
        height: height * 0.06,
        width: width * 0.3,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.pink[200]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton1(double height, double width, String label,
      [Color? backgroundColor]) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(
          msg: "Product successfully added to cart!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.pink[200],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      child: Container(
        height: height * 0.06,
        width: width * 0.3,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.pink[200]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
