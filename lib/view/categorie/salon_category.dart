import 'package:beautybazzle/model/addsalon/addsalon.dart';
import 'package:beautybazzle/view/categorie/salons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SalonCategoryScreen extends StatefulWidget {
  SalonCategoryScreen({
    super.key,
  });

  @override
  State<SalonCategoryScreen> createState() => _SalonCategoryScreenState();
}

class _SalonCategoryScreenState extends State<SalonCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SalonModel != null
        ? Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
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
                            child: const Icon(Icons.arrow_back,
                                color: Colors.black),
                          ),
                        ),
                        Text(
                          "Salons Categories",
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.person,
                              size: 26, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Expanded(
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset:
                                Offset(0, 50 * (1 - value)), // Slide-in effect
                            child: child,
                          ),
                        );
                      },
                      child: _buildSalonList(height, width),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: height,
            width: width,
            color: Colors.pink.withOpacity(0.3),
            child: Center(child: SpinKitSpinningLines(color: Colors.pink)),
          );
  }

  Widget _buildSalonList(double height, double width) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('salons').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Salons available'));
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            SalonModel model = SalonModel.fromMap(
                snapshot.data!.docs[index].data() as Map<String, dynamic>);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalonsScreen(model: model),
                      ));
                },
                child: Container(
                  height: height * 0.12,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: width * 0.002,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: height * 0.07,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(model.SalonPicture ?? ''),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    title: Text(
                      model.SalonName ?? '',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      model.SalonName ?? '',
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
          },
        );
      },
    );
  }
}
