import 'dart:async';

import 'package:beautybazzle/model/signup_login/signup_model.dart';
import 'package:beautybazzle/view/profiles/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpecialistsScreen extends StatefulWidget {
  const SpecialistsScreen({super.key});

  @override
  State<SpecialistsScreen> createState() => _SpecialistsScreenState();
}

class _SpecialistsScreenState extends State<SpecialistsScreen> {
  final double rating = 4.0;
  final List<int> favoriteSpecialistIndices = [];

  StreamSubscription<QuerySnapshot>? _specialistsStream;
  List<UserModels> _specialists = [];

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    _specialistsStream = FirebaseFirestore.instance
        .collection('Users')
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          _specialists = snapshot.docs
              .map((doc) =>
                  UserModels.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
        });
      }
    });
  }

  @override
  void dispose() {
    _specialistsStream?.cancel();
    super.dispose();
  }

  void toggleFavorite(int index) {
    setState(() {
      if (favoriteSpecialistIndices.contains(index)) {
        favoriteSpecialistIndices.remove(index);
      } else {
        favoriteSpecialistIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: height * 0.05),
            _buildAppBar(width),
            SizedBox(height: height * 0.02),
            Expanded(
              child: _specialists.isEmpty
                  ? _buildLoadingState()
                  : _buildSpecialistsList(height, width),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            "Beauty Specialists",
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
            ),
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 26),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: SpinKitSpinningLines(
        color: Colors.pink,
        size: 50.0,
      ),
    );
  }

  Widget _buildSpecialistsList(double height, double width) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20),
      itemCount: (_specialists.length / 2).ceil(),
      itemBuilder: (context, rowIndex) {
        final firstIndex = rowIndex * 2;
        final secondIndex =
            firstIndex + 1 < _specialists.length ? firstIndex + 1 : null;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSpecialistCard(
                  height, width, _specialists[firstIndex], firstIndex),
              if (secondIndex != null)
                _buildSpecialistCard(
                    height, width, _specialists[secondIndex], secondIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecialistCard(
      double height, double width, UserModels model, int index) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(model1: model)),
            );
          },
          child: Stack(
            children: [
              Container(
                height: height * 0.22,
                width: width * 0.40,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(model.ProfilePicture ?? ''),
                    ),
                    SizedBox(height: 8),
                    Text(
                      model.name ?? 'No Name',
                      style: TextStyle(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingStars(
                          value: rating,
                          starCount: 5,
                          starSize: 12,
                          starColor: const Color.fromARGB(255, 241, 134, 170),
                        ),
                        SizedBox(width: width * 0.03),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () => toggleFavorite(index),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(
                      favoriteSpecialistIndices.contains(index)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteSpecialistIndices.contains(index)
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
  }
}
