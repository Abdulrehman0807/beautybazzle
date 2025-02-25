import 'dart:io';

import 'package:beautybazzle/model/addoffer.dart';
import 'package:beautybazzle/model/signup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import '../utiils/static_data.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  final formKey = GlobalKey<FormState>();
  UserModels? usermodel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController offerNameController = TextEditingController();
  TextEditingController servicnameController = TextEditingController();
  TextEditingController servicdescriptionController = TextEditingController();
  File? offerPic;
  final ImagePicker picker = ImagePicker();
  String? offerPicUrl;
  bool isLoading = false;
  bool isLoadingSalon = false;
  bool isLoadingProfile = false;

  bool isFavorite = false;

  void toggleFavorite() {
    isFavorite = !isFavorite; // Toggle favorite state
    update();
  }

  changeLoadingStatus(bool v) {
    isLoading = v;
    update();
  }

  changeLoadingProfile(bool v) {
    isLoadingProfile = v;
    update();
  }

  changeLoadingSalon(bool v) {
    isLoadingSalon = v;
    update();
  }

  getUserProfile(String userID) async {
// Fetch updated user data
    QuerySnapshot snapshot = await firestore
        .collection("Users")
        .where("UserId", isEqualTo: userID)
        .get();
    UserModels model =
        UserModels.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
    StaticData.userModel = model;
    usermodel = model;
    update();
  }

  Future<void> saveProfileData(BuildContext context) async {
    if (isLoading) return; // Prevent multiple clicks

    changeLoadingStatus(true);

    try {
      String userId = StaticData.userModel!.UserId;

      // Update user profile in Firestore
      await firestore.collection("Users").doc(userId).update({
        'name': nameController.text.trim(),
        'SalonName': salonNameController.text.trim(),
        'Address': addressController.text.trim(),
        'YouTube': youtubeController.text.trim(),
        'Facebook': facebookController.text.trim(),
        'Instagram': instagramController.text.trim(),
        'TikTok': tiktokController.text.trim(),
        'AboutMe': aboutMeController.text.trim(),
      });

      getUserProfile(userId);

      // Show success message
      showToast("Profile updated successfully!", Colors.green);
      Navigator.pop(context); // Navigate back

    } catch (e) {
      showToast("Error updating profile: $e", Colors.red);
    } finally {
      changeLoadingStatus(false);
    }
  }

  // Validate YouTube link
  bool isValidYouTubeLink(String url) {
    final youtubeRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/.+$',
      caseSensitive: false,
    );
    return youtubeRegex.hasMatch(url);
  }

  // Validate Facebook link
  bool isValidFacebookLink(String url) {
    final facebookRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(facebook\.com)\/.+$',
      caseSensitive: false,
    );
    return facebookRegex.hasMatch(url);
  }

  // Validate Instagram link
  bool isValidInstagramLink(String url) {
    final instagramRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(instagram\.com|instagr\.am)\/.+$',
      caseSensitive: false,
    );
    return instagramRegex.hasMatch(url);
  }

  // Validate TikTok link
  bool isValidTikTokLink(String url) {
    final tiktokRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(tiktok\.com)\/.+$',
      caseSensitive: false,
    );
    return tiktokRegex.hasMatch(url);
  }

  // Show toast message
  void showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final ImagePicker picker = ImagePicker();
  XFile? photo;

// Upload Salon Picture
  Future<void> pickSalonPicture(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext dc) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: const Text('Choose an image from the camera or gallery.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickFromCamera(isSalon: true, context: context);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickFromGallery(isSalon: true, context: context);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

// Upload Profile Picture
  Future<void> pickProfilePicture(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext dc) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: const Text('Choose an image from the camera or gallery.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickFromCamera(isSalon: false, context: context);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickFromGallery(isSalon: false, context: context);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

// Pick from Gallery
  Future<void> pickFromGallery(
      {required bool isSalon, required BuildContext context}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = pickedFile;
      await uploadImage(isSalon: isSalon, context: context);
      update();
    }
  }

// Pick from Camera
  Future<void> pickFromCamera(
      {required bool isSalon, required BuildContext context}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = pickedFile;
      await uploadImage(isSalon: isSalon, context: context);
      update();
    }
  }

// Upload Image to Firebase Storage and Save to Firestore
  Future<void> uploadImage(
      {required bool isSalon, required BuildContext context}) async {
    if (photo == null) return;

    // Show loading indicator
    if (isSalon) {
      changeLoadingSalon(true);
    } else {
      changeLoadingProfile(true);
    }

    try {
      // Select folder based on the image type (Salon/Profile)
      final folder = isSalon ? 'salon_pictures' : 'profile_pictures';
      final ref = storage.ref().child('$folder/${photo!.name}');

      // Upload the image to Firebase Storage
      await ref.putData(
        await photo!.readAsBytes(),
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );

      // Get the download URL of the uploaded image
      final downloadUrl = await ref.getDownloadURL();

      // Save the URL to Firestore - Update either profile or salon picture based on the context
      Map<String, dynamic> updateData;
      if (isSalon) {
        updateData = {'SalonPicture': downloadUrl};
      } else {
        updateData = {'ProfilePicture': downloadUrl};
      }

      await firestore
          .collection("Users")
          .doc(StaticData.userModel!.UserId)
          .update(updateData);
      getUserProfile(StaticData.userModel!.UserId);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${isSalon ? "Salon" : "Profile"} image uploaded successfully!'),
        ),
      );
    } catch (e) {
      // Log and show error message if upload fails
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to upload ${isSalon ? "salon" : "profile"} image!'),
        ),
      );
    } finally {
      // Hide loading indicator
      if (isSalon) {
        changeLoadingSalon(false);
      } else {
        changeLoadingProfile(false);
      }
    }
  }

  /////////////////////////

  // Function to pick an image from the gallery
  // Future<void> pickImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     offerPic = pickedFile;
  //     update();
  //   }
  // }

  // Future<void> createOfferCollection(BuildContext context) async {
  //   try {
  //     // Create a UUID for the offer
  //     var uuid = const Uuid();
  //     String userId = uuid.v4(); // Generate a unique offerId
  //     String offerId = uuid.v4();
  //     // Get the current time
  //     String time = DateTime.now().toIso8601String();

  //     // If the user picked an image, upload it to Firebase Storage
  //     String? offerPicUrl = '';
  //     if (offerPic != null) {
  //       // Upload the image to Firebase Storage
  //       firebase_storage.Reference ref = firebase_storage
  //           .FirebaseStorage.instance
  //           .ref()
  //           .child('offer_pics/$offerId'); // Unique file path using offerId
  //       await ref.putFile(File(offerPic!.path));

  //       // Get the download URL
  //       offerPicUrl = await ref.getDownloadURL();
  //     }

  //     // Create the OfferModel object with the provided data
  //     OfferModel model = OfferModel(
  //       offerId: offerId,
  //       offerName: offerNameController.text,
  //       offerPic:
  //           offerPicUrl ?? '', // If no image was picked, use an empty string
  //       time: time,
  //       userId: userId,
  //     );

  //     // Insert the model into the "offers" collection with the generated offerId as the document ID
  //     await FirebaseFirestore.instance
  //         .collection("offers")
  //         .doc(userId) // Set the document ID as the offerId
  //         .set(model.toMap()); // Set the data to Firebase

  //     print("Offer created with offerId: $userId");

  //     // Show success message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Offer created successfully!')),
  //     );
  //   } catch (e) {
  //     print("Error creating offer: $e");

  //     // Show error message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to create offer.')),
  //     );
  //   }
  // }

  // // Method to show dialog box
  // void showOfferDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Form(
  //             key: formKey,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 // Offer Name Field
  //                 TextFormField(
  //                   controller: offerNameController,
  //                   decoration: InputDecoration(
  //                     labelText: 'Offer Name',
  //                     border: OutlineInputBorder(),
  //                   ),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter an offer name';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 SizedBox(height: 16),

  //                 // Offer Picture Button
  //                 ElevatedButton(
  //                   onPressed: pickImage,
  //                   child: Text('Pick Offer Picture'),
  //                 ),
  //                 SizedBox(height: 16),

  //                 // Image Preview (if available)
  //                 offerPic != null
  //                     ? Image.file(File(offerPic!.path), height: 150)
  //                     : Container(
  //                         height: 150,
  //                         color: Colors.grey[200],
  //                         child: Center(child: Text('No image selected')),
  //                       ),
  //                 SizedBox(height: 24),

  //                 // Submit Button
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     if (formKey.currentState!.validate()) {
  //                       createOfferCollection(context);
  //                       Navigator.of(context).pop(); // Close the dialog
  //                     }
  //                   },
  //                   child: Text('Create Offer'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

// Fetch offers from Firestore
  Stream<List<OfferModel>> getOffers() {
    return FirebaseFirestore.instance.collection('offers').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => OfferModel.fromMap(doc.data()))
            .toList());
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      offerPic = File(pickedFile.path);
      update();
    }
  }

  Future<void> createOfferCollection(BuildContext context) async {
    try {
      var uuid = const Uuid();
      String offerId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String userId = FirebaseAuth.instance.currentUser?.uid ?? uuid.v4();

      String? offerPicUrl;
      if (offerPic != null) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('offer_pics/$offerId');
        await ref.putFile(offerPic!);
        offerPicUrl = await ref.getDownloadURL();
      }

      OfferModel model = OfferModel(
        offerId: offerId,
        offerName: offerNameController.text,
        offerPic: offerPicUrl ?? '',
        time: time,
        userId: userId,
      );

      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .set(model.toMap());

      print("Offer created with offerId: $offerId");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Offer created successfully!')),
      );

      // Clear the form fields and reset the image picker
      offerNameController.clear();
      offerPic = null;
      // notifyListeners(); // Call this if using state management

    } catch (e) {
      print("Error creating offer: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create offer.')),
      );
    }
  }

  Future<void> deleteOffer(String offerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .delete();
      print("Offer deleted with offerId: $offerId");
    } catch (e) {
      print("Error deleting offer: $e");
    }
  }

  void showOfferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: offerNameController,
                    decoration: InputDecoration(
                      labelText: 'Offer Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an offer name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Pick Offer Picture'),
                  ),
                  SizedBox(height: 16),
                  offerPic != null
                      ? Image.file(File(offerPic!.path), height: 150)
                      : Container(
                          height: 150,
                          color: Colors.grey[200],
                          child: Center(child: Text('No image selected')),
                        ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        createOfferCollection(context);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Create Offer'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
