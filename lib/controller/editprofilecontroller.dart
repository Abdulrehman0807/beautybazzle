import 'dart:io';
import 'package:beautybazzle/model/addoffer.dart';
import 'package:beautybazzle/model/addproduct.dart';
import 'package:beautybazzle/model/addservices.dart';
import 'package:beautybazzle/model/addspecialist.dart';
import 'package:beautybazzle/model/addwork.dart';
import 'package:beautybazzle/model/signup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController servicnameController = TextEditingController();
  final TextEditingController servicdescriptionController =
      TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController specialistNameController =
      TextEditingController();
  final TextEditingController specialistServiceNameController =
      TextEditingController();
  final TextEditingController workTypeController = TextEditingController();
  File? productPic;
  File? offerPic;
  File? specialistPic;
  File? recentWorkPic;
  File? servicePic;
  final ImagePicker picker = ImagePicker();
  String? offerPicUrl;
  String? productPicUrl;
  String? specialistPicUrl;
  String? recentworkPicUrl;
  String? servicePicUrl;
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

  ///////////////////////// offer add //////////////////////////

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
      String? offerPicUrl = '';
      if (offerPic != null) {
        // Upload the image to Firebase Storage
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('offer_pics/$offerId'); // Unique file path using offerId
        await ref.putFile(File(offerPic!.path));

        // Get the download URL
        offerPicUrl = await ref.getDownloadURL();
      }
      OfferModel model = OfferModel(
        offerId: offerId,
        offerName: offerNameController.text,
        offerPic: offerPicUrl ?? '',
        time: time,
        userId: StaticData.userModel!.UserId,
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
      update();
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

  void showOfferDialog(BuildContext context) {}

  ////////////// add services //////////////////

  Future<void> pickServiceImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      servicePic = File(pickedFile.path);
      update();
    }
  }

  Future<void> createServiceCollection(BuildContext context) async {
    try {
      var uuid = const Uuid();
      String serviceId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? servicePicUrl = '';

      if (servicePic != null) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('service_pics/$serviceId');

        // Upload the file
        await ref.putFile(File(servicePic!.path));

        // Get the download URL
        servicePicUrl = await ref.getDownloadURL();

        // Show success toast after the image is uploaded
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ServiceModel model = ServiceModel(
        serviceId: serviceId,
        serviceName: serviceNameController.text,
        serviceDescription: serviceDescriptionController.text,
        servicePic: servicePicUrl ?? '',
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save the service to Firestore
      await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .set(model.toMap());

      // Show success toast for service creation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form fields and reset the image picker
      serviceNameController.clear();
      serviceDescriptionController.clear();
      servicePic = null;
      update();
    } catch (e) {
      print("Error creating service: $e");

      // Show error toast in case of failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create service. Try again!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void deleteService(BuildContext context, String serviceId) async {
    try {
      // Deleting the service from Firestore
      await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .delete();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service deleted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Show an error message if deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting service: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

//////////////////////
//   void showUpdateServiceDialog(BuildContext context, ServiceModel model) {
//     // Pre-fill the controllers with existing data
//     serviceNameController.text = model.serviceName ?? '';
//     serviceDescriptionController.text = model.serviceDescription ?? '';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Update Service'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Service Name Input
//               TextField(
//                 controller: serviceNameController,
//                 decoration: InputDecoration(hintText: 'Service Name'),
//               ),
//               SizedBox(height: 10),
//               // Service Description Input
//               TextField(
//                 controller: serviceDescriptionController,
//                 decoration: InputDecoration(hintText: 'Service Description'),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () async {
//                 // Update the service in Firestore
//                 await updateServiceInFirestore(
//                   model.serviceId!,
//                   serviceNameController.text,
//                   serviceDescriptionController.text,
//                 );
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

// // Function to update the service details in Firestore
//   Future<void> updateServiceInFirestore(
//     String serviceId,
//     String newServiceName,
//     String newDescription,
//   ) async {
//     try {
//       // Update the service data in Firestore
//       await FirebaseFirestore.instance
//           .collection('services')
//           .doc(serviceId)
//           .update({
//         'serviceName': newServiceName,
//         'serviceDescription': newDescription,
//       });

//       // Show success message
//       print("Service updated successfully!");
//     } catch (e) {
//       // Show error message if update fails
//       print("Error updating service: $e");
//     }
//   }

//////////////// add product ////////////
  Future<void> pickProductImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productPic = File(pickedFile.path);
    }
  }

  Future<void> createProductCollection(BuildContext context) async {
    try {
      var uuid = const Uuid();
      String productId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? productPicUrl = '';

      if (productPic != null) {
        // Upload the image to Firebase Storage
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child(
                'product_pics/$productId'); // Unique file path using productId
        await ref.putFile(File(productPic!.path));

        // Get the download URL
        productPicUrl = await ref.getDownloadURL();
      }

      ProductModel model = ProductModel(
        productId: productId,
        productName: productNameController.text,
        productPrice: productPriceController.text,
        productPic: productPicUrl ?? '',
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save product to Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .set(model.toMap());

      print("Product created with productId: $productId");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product created successfully!')),
      );

      productNameController.clear();
      productPriceController.clear();

      productPic = null;
    } catch (e) {
      print("Error creating product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create product.')),
      );
    }
  }

  Future<void> deleteProduct(BuildContext context, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product deleted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Show an error message if deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting product: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /////////////////add specialist ////////////
  Future<void> pickSpecialistImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      specialistPic = File(pickedFile.path);
    }
  }

  Future<void> createSpecialistCollection(BuildContext context) async {
    try {
      var uuid = const Uuid();
      String specialistId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? specialistPicUrl = '';

      if (specialistPic != null) {
        // Upload the image to Firebase Storage
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('Specialist_pics/$specialistId');
        await ref.putFile(File(specialistPic!.path));

        // Get the download URL
        specialistPicUrl = await ref.getDownloadURL();
      }

      // Create the SpecialistModel
      SpecialistModel model = SpecialistModel(
        specialistId: specialistId,
        specialistName: specialistNameController.text,
        specialistServiceName: specialistServiceNameController.text,
        specialistPic: specialistPicUrl,
        time: time,
        userId: StaticData.userModel!.UserId, // Replace with actual user ID
      );

      // Save the specialist to Firestore
      await FirebaseFirestore.instance
          .collection('specialists')
          .doc(specialistId)
          .set(model.toMap());

      print("Specialist created with specialistId: $specialistId");

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Specialist created successfully!')),
      );

      // Clear the form
      specialistNameController.clear();
      specialistServiceNameController.clear();
      specialistPic = null;
    } catch (e) {
      print("Error creating specialist: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create specialist.')),
      );
    }
  }

  Future<void> deleteSpecialist(String specialistId) async {
    try {
      await FirebaseFirestore.instance
          .collection('specialists')
          .doc(specialistId)
          .delete();
      print("Specialist deleted with ID: $specialistId");
    } catch (e) {
      print("Error deleting specialist: $e");
    }
  }

////////////////////////// add recent work ////////////////
  Future<void> pickRecentworkImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      recentWorkPic = File(pickedFile.path);
      update();
    }
  }

  Future<void> createRecentworkCollection(BuildContext context) async {
    try {
      var uuid = const Uuid();
      String recentworkId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? recentworkPicUrl = ''; // Initialize it

      // Ensure the image is selected before uploading
      if (recentWorkPic != null) {
        // Upload the image to Firebase Storage
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('recentwork_pics/$recentworkId');

        // Upload the selected image file
        await ref.putFile(recentWorkPic!);

        // Get the download URL for the uploaded image
        recentworkPicUrl = await ref.getDownloadURL();
      }

      RecentWorkModel model = RecentWorkModel(
        RecentworkId: recentworkId,
        RecentworkPic: recentworkPicUrl ?? '',
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save the model to Firestore
      await FirebaseFirestore.instance
          .collection('recentworks')
          .doc(recentworkId)
          .set(model.toMap());

      print("Recent work created with ID: $recentworkId");

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recent work uploaded successfully!')),
      );

      // Clear the form fields and reset the image picker
      workTypeController.clear();
      recentWorkPic = null;
      update();
    } catch (e) {
      print("Error creating recent work: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create recent work.')),
      );
    }
  }

  Future<void> deletework(String recentworkId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recentworks')
          .doc(recentworkId)
          .delete();
      print("Recent work deleted with ID: $recentworkId");
    } catch (e) {
      print("Error deleting recent work: $e");
    }
  }
}
