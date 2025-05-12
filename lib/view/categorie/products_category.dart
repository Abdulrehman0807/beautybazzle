import 'package:beautybazzle/model/addproduct/addproduct.dart';
import 'package:beautybazzle/view/categorie/beauty_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  Text(
                    "Products Categories",
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
                        const Icon(Icons.person, size: 26, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No Products available'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ProductModel model = ProductModel.fromMap(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BeautyProductScreen(product: model),
                              ),
                            );
                          },
                          child: Container(
                            height: height * 0.12,
                            width: width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black12, width: width * 0.002),
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
                                      image:
                                          NetworkImage(model.productPic ?? ""),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                title: Text(
                                  model.productName ?? "No Name",
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  model.productDescription ?? "",
                                  style: TextStyle(
                                    fontSize: width * 0.03,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
