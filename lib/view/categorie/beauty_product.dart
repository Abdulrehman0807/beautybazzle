import 'package:beautybazzle/controller/addcart/addcart.dart';
import 'package:beautybazzle/controller/profile/editprofilecontroller.dart';
import 'package:beautybazzle/model/addproduct/addproduct.dart';
import 'package:beautybazzle/model/signup_login/signup_model.dart';
import 'package:beautybazzle/view/orders/check_out.dart';
import 'package:beautybazzle/view/profiles/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BeautyProductScreen extends StatefulWidget {
  final ProductModel product;

  BeautyProductScreen({required this.product, Key? key}) : super(key: key);

  @override
  State<BeautyProductScreen> createState() => _BeautyProductScreenState();
}

class _BeautyProductScreenState extends State<BeautyProductScreen>
    with SingleTickerProviderStateMixin {
  UserModels? usermodel;
  Future<void> fetchUserData() async {
    final userId = widget.product.userId;
    if (userId != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where("UserId", isEqualTo: widget.product.userId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          usermodel = UserModels.fromMap(
              snapshot.docs[0].data() as Map<String, dynamic>);
        });
      }
    } else {
      print("No Data Founds");
    }
  }

  double rating = 4.0;
  PageController controller = PageController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
    fetchUserData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GetBuilder<ProfileController>(
      builder: (_) {
        return DefaultTabController(
            length: 1,
            child: usermodel != null
                ? Scaffold(
                    body: Stack(
                      children: [
                        CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              expandedHeight: 250.0,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Center(
                                  child: Image.network(
                                    widget.product.productPic ?? '',
                                    fit: BoxFit.cover,
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
                                  child: _buildProductDetails(
                                      context, height, width),
                                ),
                              ]),
                            ),
                          ],
                        ),
                        _buildBottomBar(context, height, width),
                      ],
                    ),
                  )
                : Container(
                    height: height,
                    width: width,
                    color: Colors.pink.withOpacity(0.3),
                    child:
                        Center(child: SpinKitSpinningLines(color: Colors.pink)),
                  ));
      },
    );
  }

  Widget _buildProductDetails(
      BuildContext context, double height, double width) {
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        _buildProductTitleAndRating(context, height, width),
        _buildSellerCard(height, width),
        SizedBox(height: height * 0.01),
        _buildProductDetailsSection(height, width),
        _buildRelatedProductsTab(height, width),
      ],
    );
  }

  Widget _buildProductTitleAndRating(
      BuildContext context, double height, double width) {
    return Container(
      height: height * 0.04,
      width: width * 0.93,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.product.productName ?? '',
            style:
                TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600),
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
    );
  }

  Widget _buildSellerCard(double height, double width) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: height * 0.085,
        width: width * 0.95,
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage:
                NetworkImage(usermodel!.ProfilePicture), // Removed ${}
          ),
          title: Text(
            usermodel!.name, // Removed ${}
            style:
                TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Beauty Specialist",
            style:
                TextStyle(fontSize: width * 0.032, fontWeight: FontWeight.w400),
          ),
          trailing: GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: "view a Profile");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(model1: usermodel!),
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
          style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          widget.product.productDescription ?? 'No Description',
          style:
              TextStyle(fontSize: width * 0.036, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _buildRelatedProductsTab(double height, double width) {
    return SizedBox(
      height: height * 0.3,
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('products')
            .where('SalonId', isEqualTo: widget.product.userId)
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
              .where((product) => product.productId != widget.product.productId)
              .toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BeautyProductScreen(product: product),
                    ),
                  );
                },
                child: Container(
                  height: height * 0.1,
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: height * 0.07,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        image: product.productPic != null &&
                                product.productPic!.isNotEmpty
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(product.productPic!),
                              )
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    title: Text(
                      product.productName ?? '',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      product.productDescription ?? 'No Description',
                      style: TextStyle(
                        fontSize: width * 0.03,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
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
        height: height * 0.09,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              offset: Offset(0, -2),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTotalPrice(context, height, width, 'Total Price'),
              _buildBottomButton(context, height, width, 'Add to Cart'),
              _buildBottomButton(context, height, width, 'Buy Now'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(
      BuildContext context, double height, double width, String label) {
    return GestureDetector(
      onTap: () {
        final productData = {
          'id': widget.product.productId,
          'name': widget.product.productName,
          'price': widget.product.productPrice,
          'description': widget.product.productDescription,
          'image': widget.product.productPic,
          'quantity': 1,
        };

        if (label == 'Buy Now') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CheckoutScreen(product: productData),
            ),
          );
        } else if (label == 'Add to Cart') {
          final cartController = Get.find<CartController>();
          // cartController.addToCart();
          Fluttertoast.showToast(
            msg: "${widget.product.productName} added to cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      child: Container(
        height: height * 0.065,
        width: width * 0.3,
        decoration: BoxDecoration(
          color: label == 'Add to Cart' ? Colors.white : Colors.pink[200],
          borderRadius: BorderRadius.circular(10),
          border: label == 'Add to Cart'
              ? Border.all(color: Colors.pink[200]!)
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              color: label == 'Add to Cart' ? Colors.pink[200] : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalPrice(
      BuildContext context, double height, double width, String label) {
    return Container(
      height: height * 0.065,
      width: width * 0.3,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: width * 0.035, color: Colors.black),
            ),
            Text(
              '\$${widget.product.productPrice}',
              style: TextStyle(fontSize: width * 0.035, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
