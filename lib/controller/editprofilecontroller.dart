import 'package:beautybazzle/model/signup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../utiils/static_data.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();

  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoadingSalon = false;
  bool isLoadingProfile = false;
  changeLoadingStatus(bool v) {
    isLoading = v;
    update();
  }

  changeLoadingProfile(bool v) {
    isLoadingSalon = v;
    update();
  }

  changeLoadingSalon(bool v) {
    isLoadingProfile = v;
    update();
  }

  Future<void> saveProfileData(BuildContext context) async {
    if (isLoading) return; // Prevent multiple clicks

    changeLoadingStatus(true);

    try {
      String userId = StaticData.userModel!.UserId;

      // Update user profile in Firestore
      await firestore.collection("Users").doc(userId).update({
        'SalonName': salonNameController.text.trim(),
        'Address': addressController.text.trim(),
        'YouTube': youtubeController.text.trim(),
        'Facebook': facebookController.text.trim(),
        'Instagram': instagramController.text.trim(),
        'TikTok': tiktokController.text.trim(),
        'AboutMe': aboutMeController.text.trim(),
      });

      // Fetch updated user data
      QuerySnapshot snapshot = await firestore
          .collection("Users")
          .where("UserId", isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Update local user model
        UserModels model =
            UserModels.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
        StaticData.userModel = model;

        // Show success message
        showToast("Profile updated successfully!", Colors.green);
        Navigator.pop(context); // Navigate back
      } else {
        showToast("Error: Profile not updated. Try again!", Colors.red);
      }
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

  final ImagePicker picker = ImagePicker();
  XFile? photo;

  // Upload Salon Picture
  Future<void> pickSalonPicture(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      builder: (BuildContext context) {
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

  Future<void> pickFromGallery(
      {required bool isSalon, required BuildContext context}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = pickedFile;

      uploadImage(isSalon: isSalon, context: context);
      update();
    }
  }

  Future<void> pickFromCamera(
      {required bool isSalon, required BuildContext context}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = pickedFile;

      uploadImage(isSalon: isSalon, context: context);
      update();
    }
  }

  Future<void> uploadImage(
      {required bool isSalon, required BuildContext context}) async {
    if (photo == null) return;

    if (isSalon) {
      changeLoadingSalon(true);
    } else {
      changeLoadingProfile(true);
    }

    try {
      final folder = isSalon ? 'salon_pictures' : 'profile_pictures';
      final ref = storage.ref().child('$folder/${photo!.name}');

      // Upload the image to Firebase Storage
      await ref.putData(
        await photo!.readAsBytes(),
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();

      // Save the URL to Firestore
      await firestore
          .collection("Users")
          .doc(StaticData.userModel!.UserId)
          .update({
        'ProfilePicture': downloadUrl,
      });
      await firestore
          .collection("Users")
          .doc(StaticData.userModel!.UserId)
          .update({
        'SalonPicture': downloadUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${isSalon ? "Salon" : "Profile"} image uploaded successfully!')),
      );
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to upload ${isSalon ? "salon" : "profile"} image!')),
      );
    } finally {
      if (isSalon) {
        changeLoadingSalon(false);
      } else {
        changeLoadingProfile(false);
      }
    }
  }
}
