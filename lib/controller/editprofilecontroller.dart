import 'dart:io';
import 'package:beautybazzle/model/addoffer.dart';
import 'package:beautybazzle/model/addproduct.dart';
import 'package:beautybazzle/model/addsalon.dart';
import 'package:beautybazzle/model/addservices.dart';
import 'package:beautybazzle/model/addspecialist.dart';
import 'package:beautybazzle/model/addvideo.dart';
import 'package:beautybazzle/model/addwork.dart';
import 'package:beautybazzle/model/signup_model.dart';
import 'package:beautybazzle/view/setting/videoplay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import '../utiils/static_data.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  final formKey = GlobalKey<FormState>();
  UserModels? usermodel;
  SalonModel? salonmodel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController salonDescriptionController =
      TextEditingController();
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
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController specialistNameController =
      TextEditingController();
  final TextEditingController specialistServiceNameController =
      TextEditingController();
  final TextEditingController workTypeController = TextEditingController();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  XFile? photo;
  File? productPic;
  File? offerPic;
  File? specialistPic;
  File? recentWorkPic;
  File? servicePic;
  XFile? SalonPicture;
  final ImagePicker picker = ImagePicker();
  String? offerPicUrl;
  String? productPicUrl;
  String? salonPictureUrl;
  String? specialistPicUrl;
  String? recentworkPicUrl;
  String? servicePicUrl;

  bool isLoading = false;
  bool isLoadingSalon = false;
  bool isLoadingProfile = false;
  bool isLoadingOffer = false;
  bool isLoadingSpecialist = false;
  bool isLoadingProduct = false;
  bool isLoadingWork = false;
  bool isLoadingService = false;
  bool isloadingvideo = false;
  bool isFavorite = false;

  void toggleFavorite() {
    isFavorite = !isFavorite;
    update();
    Fluttertoast.showToast(
      msg: isFavorite
          ? "Successfully added to favorites"
          : "Removed from favorites",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.pink[200],
      textColor: Colors.black,
    );
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

  changeLoadingOffer(bool v) {
    isLoadingOffer = v;
    update();
  }

  changeLoadingSpecialist(bool v) {
    isLoadingSpecialist = v;
    update();
  }

  changeLoadingProduct(bool v) {
    isLoadingProduct = v;
    update();
  }

  changeLoadingWork(bool v) {
    isLoadingWork = v;
    update();
  }

  changeLoadingService(bool v) {
    isLoadingService = v;
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

    QuerySnapshot snapshotSalon = await firestore
        .collection("Salons")
        .where("UserId", isEqualTo: userID)
        .get();
    SalonModel smodel =
        SalonModel.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
    //StaticData.salonmodel = smodel;
    salonmodel = smodel;
    update();

    // QuerySnapshot snapshotprofilepicture = await firestore
    //     .collection("ProfilePicture")
    //     .where("UserId", isEqualTo: userID)
    //     .get();
    // UserModels pmodel =
    //     UserModels.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
    // StaticData.userModel = model;
    // usermodel = pmodel;
    // update();
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
        'salonDescription': salonDescriptionController.text.trim(),
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

///////////////////// upload picture //////////////////
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
                pickFromCamera(context);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickFromGallery(context);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  // Pick image from Gallery
  Future<void> pickFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = pickedFile;
      await uploadImage(context);
      update();
    }
  }

  // Pick image from Camera
  Future<void> pickFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = pickedFile;
      await uploadImage(context);
      update();
    }
  }

  // Upload image to Firebase Storage and save URL to Firestore
  Future<void> uploadImage(BuildContext context) async {
    if (photo == null) return;

    // Show loading indicator
    changeLoadingProfile(true);

    try {
      // Upload the image to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${photo!.name}');
      await ref.putData(
        await photo!.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Get the download URL of the uploaded image
      final downloadUrl = await ref.getDownloadURL();

      // Save the URL to Firestore
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(StaticData.userModel!.UserId)
          .update({'ProfilePicture': downloadUrl});

      // Refresh user profile data
      getUserProfile(StaticData.userModel!.UserId);

      // Show success message
      Fluttertoast.showToast(
        msg: 'Profile image uploaded successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      // Log and show error message if upload fails
      print('Error uploading image: $e');

      // Show error message with Toast
      Fluttertoast.showToast(
        msg: 'Failed to upload profile image!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      // Hide loading indicator
      changeLoadingProfile(false);
    }
  }

//////////////////////////// add salon ////////////////////////

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
                salonpickFromCamera(context);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                salonpickFromGallery(context);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  // Pick image from Gallery
  Future<void> salonpickFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      SalonPicture = pickedFile;
      update();
    }
  }

  // Pick image from Camera
  Future<void> salonpickFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      SalonPicture = pickedFile;
      update();
    }
  }

  // Upload Salon Picture to Firebase Storage
  Future<void> uploadSalonPicture(BuildContext context) async {
    if (SalonPicture == null) return;

    // Show loading indicator
    changeLoadingSalon(true);

    try {
      // Upload the image to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('salon_pictures/${SalonPicture!.name}');
      await ref.putFile(File(SalonPicture!.path));

      // Get the download URL of the uploaded image
      final downloadUrl = await ref.getDownloadURL();

      // Save the URL to Firestore
      await FirebaseFirestore.instance
          .collection("Salons")
          .doc(salonmodel!.SalonId)
          .update({'SalonPicture': downloadUrl});

      // Show success message
      Fluttertoast.showToast(
        msg: 'Salon image uploaded successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      // Log and show error message if upload fails
      print('Error uploading salon image: $e');

      // Show error message with Toast
      Fluttertoast.showToast(
        msg: 'Failed to upload salon image!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      // Hide loading indicator
      changeLoadingSalon(false);
    }
  }

  // Create Salon Collection in Firestore
  Future<void> createSalonCollection(BuildContext context) async {
    try {
      var uuid = const Uuid();
      String salonId = uuid.v4();
      String time = DateTime.now().toIso8601String();

      // Upload the salon picture to Firebase Storage if selected
      String? salonPictureUrl;
      if (SalonPicture != null) {
        // Show loading indicator while uploading image
        changeLoadingSalon(true);

        final ref = FirebaseStorage.instance
            .ref()
            .child('salon_pictures/$salonId'); // Unique file path using salonId
        await ref.putFile(File(SalonPicture!.path));

        // Get the download URL of the uploaded image
        salonPictureUrl = await ref.getDownloadURL();

        // Hide loading state after upload is complete
        changeLoadingSalon(false);
      }

      // Create the SalonModel object
      SalonModel model = SalonModel(
        SalonId: salonId,
        SalonName: salonNameController.text,
        salonDescription: salonDescriptionController.text,
        SalonPicture:
            salonPictureUrl ?? '', // Use uploaded image URL or empty string
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save the salon in Firestore
      await FirebaseFirestore.instance
          .collection('salons')
          .doc(salonId)
          .set(model.toMap());

      print("Salon created with salonId: $salonId");

      // Show success message
      Fluttertoast.showToast(
        msg: "Salon created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Clear form fields and reset the image picker after creation
      salonNameController.clear();
      salonDescriptionController.clear();
      SalonPicture = null;
      update(); // Update the UI after clearing the form
    } catch (e) {
      print("Error creating salon: $e");
      Fluttertoast.showToast(
        msg: "Failed to create salon.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  ///////////////////////// offer add //////////////////////////

  // Function to pick an image from the gallery
  Future<void> pickImage(
    BuildContext context,
  ) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      offerPic = File(pickedFile.path);
      update(); // Update UI
    }
  }

// Function to create the offer collection in Firestore
  Future<void> createOfferCollection(BuildContext context) async {
    try {
      var uuid = const Uuid();
      String offerId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? offerPicUrl = '';

      // Upload the image to Firebase Storage if there's an image selected
      if (offerPic != null) {
        // Show loading indicator while uploading image
        isLoadingOffer = true;
        update(); // Update the UI to show loading

        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('offer_pics/$offerId'); // Unique file path using offerId
        await ref.putFile(File(offerPic!.path));

        // Get the download URL of the uploaded image
        offerPicUrl = await ref.getDownloadURL();

        isLoadingOffer = false; // Hide loading state after upload is complete
        update(); // Update the UI again to hide the loading indicator
      }

      // Create the OfferModel object
      OfferModel model = OfferModel(
        offerId: offerId,
        offerName: offerNameController.text,
        offerPic: offerPicUrl ?? '', // If there's no image, pass empty string
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save the offer in Firestore
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .set(model.toMap());

      print("Offer created with offerId: $offerId");

      Fluttertoast.showToast(
        msg: "Offer created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Clear form fields and reset the image picker after creation
      offerNameController.clear();
      offerPic = null;
      update(); // Update the UI after clearing the form
    } catch (e) {
      print("Error creating offer: $e");
      Fluttertoast.showToast(
        msg: "Failed to create offer.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

// Function to delete an offer from Firestore
  Future<void> deleteOffer(String offerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .delete();
      print("Offer deleted with offerId: $offerId");

      Fluttertoast.showToast(
        msg: 'Offer deleted successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print("Error deleting offer: $e");
      Fluttertoast.showToast(
        msg: 'Failed to delete the offer.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

// Function to show the dialog to add an offer
  void showAddOfferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dc) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: Stack(
                children: [
                  AlertDialog(
                    title: const Center(child: Text("Add a Best Offer")),
                    content: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 500,
                            child: TextFormField(
                              controller: offerNameController,
                              decoration: const InputDecoration(
                                labelText: 'Offer Name',
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an Offer name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 22),
                          InkWell(
                            onTap: () => pickImage(context),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    border: Border.all(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: offerPic != null
                                      ? Image.file(
                                          File(offerPic!.path),
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.camera_alt,
                                          size: 50,
                                          color: Colors.black45,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              await createOfferCollection(context);

                              isLoading = false;
                              Navigator.of(dc).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 130,
                              vertical: 10,
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  if (isLoading) // Show the overlay spinner when isLoading is true
                    Container(
                      height: 800,
                      width: 500,
                      color: Colors.pink.withOpacity(0.3),
                      child: Center(
                        child: SpinKitSpinningLines(color: Colors.pink),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ////////////// add services //////////////////

  Future<void> pickServiceImage(BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        servicePic = File(pickedFile.path);
        update(); // Update the UI
      }
    } catch (e) {
      print("Error picking image: $e");
      Fluttertoast.showToast(
        msg: "Failed to pick image. Error: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> createServiceCollection(BuildContext context) async {
    if (isLoadingService) return; // Prevent multiple submissions

    try {
      isLoadingService = true;
      update(); // Show loading state

      var uuid = const Uuid();
      String serviceId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? servicePicUrl;

      // Upload image to Firebase Storage if an image is selected
      if (servicePic != null) {
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child(
                'service_pics/$serviceId'); // Unique file path using serviceId
        await ref.putFile(File(servicePic!.path));
        servicePicUrl = await ref.getDownloadURL();

        Fluttertoast.showToast(
          msg: "Image uploaded successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "No image selected!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      // Create ServiceModel
      ServiceModel model = ServiceModel(
        serviceId: serviceId,
        serviceName: serviceNameController.text,
        serviceDescription: serviceDescriptionController.text,
        servicePic: servicePicUrl ?? '', // Handle null gracefully
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save service to Firestore
      await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .set(model.toMap());

      Fluttertoast.showToast(
        msg: "Service created successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Clear form fields and reset image picker
      serviceNameController.clear();
      serviceDescriptionController.clear();
      servicePic = null;
      update(); // Update the UI
    } catch (e) {
      print("Error creating service: $e");
      Fluttertoast.showToast(
        msg: "Failed to create service. Try again!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoadingService = false;
      update(); // Hide loading state
    }
  }

// Delete service from Firestore
  Future<void> deleteService(BuildContext context, String serviceId) async {
    try {
      await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .delete();

      Fluttertoast.showToast(
        msg: "Service deleted successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      print("Error deleting service: $e");
      Fluttertoast.showToast(
        msg: "Error deleting service: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Show dialog to add a service
  void showAddServiceDialog(BuildContext context, double width, double height) {
    showDialog(
      context: context,
      builder: (BuildContext dc) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: GetBuilder<ProfileController>(builder: (obj) {
                return AlertDialog(
                  title: const Center(child: Text("Add a Best Service")),
                  content: Form(
                    key: formKey,
                    child: Container(
                      height: height * 0.38,
                      width: width,
                      child: Stack(
                        children: [
                          Container(
                            height: height,
                            width: width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Service Name Field
                                  TextFormField(
                                    controller: serviceNameController,
                                    decoration: const InputDecoration(
                                      hintText: "Service Name",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a service name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: height * 0.03),

                                  // Service Description Field
                                  TextFormField(
                                    controller: serviceDescriptionController,
                                    decoration: const InputDecoration(
                                      hintText: "Description",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a description for the service';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: height * 0.03),

                                  // Image Picker
                                  InkWell(
                                    onTap: () => pickServiceImage(context),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[350],
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: obj.servicePic != null
                                              ? Image.file(
                                                  File(obj.servicePic!.path),
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(
                                                  Icons.camera_alt,
                                                  size: 50,
                                                  color: Colors.black45,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (obj.isLoadingService)
                            SpinKitSpinningLines(
                              color: Colors.pink,
                            ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await createServiceCollection(context);
                            Navigator.of(dc).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 130,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                );
              }),
            );
          },
        );
      },
    );
  }

//////////////// add product ////////////

  Future<void> pickProductImage(BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        productPic = File(pickedFile.path);
        update(); // Update the UI
      }
    } catch (e) {
      print("Error picking image: $e");
      Fluttertoast.showToast(
        msg: "Failed to pick image. Please try again.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Create product collection in Firestore
  Future<void> createProductCollection(BuildContext context) async {
    if (isLoadingProduct) return; // Prevent multiple submissions

    try {
      isLoadingProduct = true;
      update(); // Show loading state

      var uuid = const Uuid();
      String productId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? productPicUrl = '';

      // Upload image to Firebase Storage if an image is selected
      if (productPic != null) {
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child(
                'product_pics/$productId'); // Unique file path using productId
        await ref.putFile(File(productPic!.path));
        productPicUrl = await ref.getDownloadURL();
      }

      // Create ProductModel
      ProductModel model = ProductModel(
        productId: productId,
        productName: productNameController.text,
        productPrice: productPriceController.text,
        productDescription: productDescriptionController.text,
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

      Fluttertoast.showToast(
        msg: "Product created successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Clear form fields and reset image picker
      productNameController.clear();
      productPriceController.clear();
      productDescriptionController.clear();
      productPic = null;
      update(); // Update the UI
    } catch (e) {
      print("Error creating product: $e");
      Fluttertoast.showToast(
        msg: "Failed to create product. Try again!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoadingProduct = false;
      update(); // Hide loading state
    }
  }

// Delete product from Firestore
  Future<void> deleteProduct(BuildContext context, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();

      Fluttertoast.showToast(
        msg: "Product deleted successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      print("Error deleting product: $e");
      Fluttertoast.showToast(
        msg: "Error deleting product: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Show dialog to add a product
  void showAddProductDialog(BuildContext context, double width, double height) {
    showDialog(
      context: context,
      builder: (BuildContext dc) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: GetBuilder<ProfileController>(builder: (obj) {
                return AlertDialog(
                  title: const Center(child: Text("Add a Best Product")),
                  content: Form(
                    key: formKey,
                    child: Container(
                      height: height * 0.48,
                      width: width,
                      child: Stack(
                        children: [
                          Container(
                            height: height,
                            width: width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Product Name Field
                                  TextFormField(
                                    controller: productNameController,
                                    decoration: const InputDecoration(
                                      hintText: "Product Name",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a product name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: height * 0.03),

                                  // Product Price Field
                                  TextFormField(
                                    controller: productPriceController,
                                    decoration: const InputDecoration(
                                      hintText: "Product Price",
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a product price';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  TextFormField(
                                    controller:
                                        obj.productDescriptionController,
                                    maxLines: 2,
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Tell us about your Product Description",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter something about your Product Description.";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: height * 0.03),

                                  // Image Picker
                                  InkWell(
                                    onTap: () => pickProductImage(context),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[350],
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: obj.productPic != null
                                              ? Image.file(
                                                  File(obj.productPic!.path),
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(
                                                  Icons.camera_alt,
                                                  size: 50,
                                                  color: Colors.black45,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (obj.isLoadingProduct)
                            SpinKitSpinningLines(
                              color: Colors.pink,
                            ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await createProductCollection(context);
                            Navigator.of(dc).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 130,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                );
              }),
            );
          },
        );
      },
    );
  }

  /////////////////add specialist ////////////

  Future<void> pickSpecialistImage(BuildContext context) async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        specialistPic = File(pickedFile.path);

        update(); // Update the UI
      }
    } catch (e) {
      print("Error picking image: $e");
      Fluttertoast.showToast(
        msg: "Failed to pick image. Please try again.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Create specialist collection in Firestore
  Future<void> createSpecialistCollection(BuildContext context) async {
    if (isLoadingSpecialist) return; // Prevent multiple submissions

    try {
      isLoadingSpecialist = true;
      update(); // Show loading state

      var uuid = const Uuid();
      String specialistId = uuid.v4();
      String time = DateTime.now().toIso8601String();
      String? specialistPicUrl = '';

      // Upload image to Firebase Storage if an image is selected
      if (specialistPic != null) {
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child(
                'Specialist_pics/$specialistId'); // Unique file path using specialistId
        await ref.putFile(File(specialistPic!.path));
        specialistPicUrl = await ref.getDownloadURL();
      }

      // Create SpecialistModel
      SpecialistModel model = SpecialistModel(
        specialistId: specialistId,
        specialistName: specialistNameController.text,
        specialistServiceName: specialistServiceNameController.text,
        specialistPic: specialistPicUrl ?? '',
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save specialist to Firestore
      await FirebaseFirestore.instance
          .collection('specialists')
          .doc(specialistId)
          .set(model.toMap());

      print("Specialist created with specialistId: $specialistId");

      Fluttertoast.showToast(
        msg: "Specialist created successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Clear form fields and reset image picker
      specialistNameController.clear();
      specialistServiceNameController.clear();
      specialistPic = null;
      update(); // Update the UI
    } catch (e) {
      print("Error creating specialist: $e");
      Fluttertoast.showToast(
        msg: "Failed to create specialist. Try again!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoadingSpecialist = false;
      update(); // Hide loading state
    }
  }

// Delete specialist from Firestore
  Future<void> deleteSpecialist(
      BuildContext context, String specialistId) async {
    try {
      await FirebaseFirestore.instance
          .collection('specialists')
          .doc(specialistId)
          .delete();

      Fluttertoast.showToast(
        msg: "Specialist deleted successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      print("Error deleting specialist: $e");
      Fluttertoast.showToast(
        msg: "Error deleting specialist: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Show dialog to add a specialist
  void showAddSpecialistDialog(
      BuildContext context, double width, double height) {
    showDialog(
      context: context,
      builder: (BuildContext dc) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: GetBuilder<ProfileController>(builder: (obj) {
                return AlertDialog(
                  title: const Center(child: Text("Add a Best Specialist")),
                  content: Container(
                    height: height * 0.38,
                    width: width,
                    child: Stack(
                      children: [
                        Container(
                          height: height,
                          width: width,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Specialist Name Field
                                TextFormField(
                                  controller: specialistNameController,
                                  decoration: const InputDecoration(
                                    hintText: "Specialist Name",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a specialist name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: height * 0.03),

                                // Specialist Service Name Field
                                TextFormField(
                                  controller: specialistServiceNameController,
                                  decoration: const InputDecoration(
                                    hintText: "Specialist Service Name",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a service name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: height * 0.03),

                                // Image Picker
                                InkWell(
                                  onTap: () => pickSpecialistImage(context),
                                  child: Container(
                                    height: 150,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: obj.specialistPic != null
                                        ? Image.file(
                                            File(obj.specialistPic!.path),
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.camera_alt,
                                            size: 50,
                                            color: Colors.black45,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (obj.isLoadingSpecialist)
                          Center(
                            child: SpinKitSpinningLines(
                              color: Colors.pink,
                            ),
                          ),
                      ],
                    ),
                  ),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (specialistNameController.text.isNotEmpty &&
                              specialistServiceNameController.text.isNotEmpty) {
                            await createSpecialistCollection(context);
                            Navigator.of(dc).pop();
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please fill all fields",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 130, // Horizontal padding
                            vertical: 10, // Vertical padding
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                );
              }),
            );
          },
        );
      },
    );
  }

////////////////////////// add recent work ////////////////

  Future<void> pickRecentworkImage(BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        recentWorkPic = File(pickedFile.path);
        update(); // Update the UI after picking the image
      } else {
        Fluttertoast.showToast(
          msg: 'No image selected.',
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Error picking recent work image: $e");
      Fluttertoast.showToast(
        msg: 'Failed to pick image. Try again.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> createRecentworkCollection(BuildContext context) async {
    if (isLoadingWork) return; // Prevent multiple submissions

    try {
      isLoadingWork = true;
      update(); // Show loading state

      final uuid = const Uuid();
      final recentworkId = uuid.v4();
      final time = DateTime.now().toIso8601String();
      String? recentworkPicUrl;

      // Upload image to Firebase Storage if an image is selected
      if (recentWorkPic != null) {
        final ref = firebase_storage.FirebaseStorage.instance.ref(
            'recentwork_pics/$recentworkId'); // Unique file path using recentworkId
        await ref.putFile(recentWorkPic!);
        recentworkPicUrl = await ref.getDownloadURL();
      }

      // Create RecentWorkModel
      final model = RecentWorkModel(
        RecentworkId: recentworkId,
        RecentworkPic: recentworkPicUrl ?? '',
        time: time,
        userId: StaticData.userModel!.UserId,
      );

      // Save recent work to Firestore
      await FirebaseFirestore.instance
          .collection('recentworks')
          .doc(recentworkId)
          .set(model.toMap());

      Fluttertoast.showToast(
        msg: 'Recent work uploaded successfully!',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Clear form fields and reset image picker
      workTypeController.clear();
      recentWorkPic = null;
      update(); // Update the UI
    } catch (e) {
      print("Error creating recent work: $e");
      Fluttertoast.showToast(
        msg: 'Failed to create recent work. Please try again.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoadingWork = false;
      update(); // Hide loading state
    }
  }

  Future<void> deleteWork(BuildContext context, String recentworkId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recentworks')
          .doc(recentworkId)
          .delete();

      Fluttertoast.showToast(
        msg: 'Recent work deleted successfully!',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      print("Error deleting recent work: $e");
      Fluttertoast.showToast(
        msg: 'Error deleting recent work. Please try again.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void showAddRecentWorkDialog(
      BuildContext context, double width, double height) {
    showDialog(
      context: context,
      builder: (BuildContext dc) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: GetBuilder<ProfileController>(builder: (obj) {
                return AlertDialog(
                  title: const Center(child: Text("Add Best Work")),
                  content: Form(
                    key: formKey,
                    child: Container(
                      height: height * 0.3,
                      width: width,
                      child: Stack(
                        children: [
                          Container(
                            height: height,
                            width: width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Work Type Field
                                  Container(
                                    width: width,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: TextFormField(
                                      controller: workTypeController,
                                      decoration: const InputDecoration(
                                        labelText: 'Work Type',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a work type';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),

                                  // Image Picker
                                  InkWell(
                                    onTap: () => pickRecentworkImage(context),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[350],
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: obj.recentWorkPic != null
                                              ? Image.file(
                                                  File(obj.recentWorkPic!.path),
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(
                                                  Icons.camera_alt,
                                                  size: 50,
                                                  color: Colors.black45,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (obj.isLoadingWork)
                            const SpinKitSpinningLines(
                              color: Colors.pink,
                            ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await createRecentworkCollection(context);
                            Navigator.of(dc).pop(); // Close dialog
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 130,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                );
              }),
            );
          },
        );
      },
    );
  }

  //////////////////////////video upload ////////////////////////

  File? videoFile;
  Future<void> pickVideo(BuildContext context) async {
    try {
      // Pick a video from the gallery
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        videoFile = File(pickedFile.path);
        print('Video selected: ${videoFile!.path}');
      }
    } catch (e) {
      print("Error picking video: $e");

      Fluttertoast.showToast(
        msg: "Failed to Picking video. Try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> uploadVideo(BuildContext context) async {
    if (isLoading || videoFile == null) return; // Prevent multiple submissions

    try {
      isLoading = true;

      // Generate unique IDs and timestamps
      var uuid = Uuid();
      String highlightId = uuid.v4();
      String time = DateTime.now().toIso8601String();

      // Upload video to Firebase Storage
      Reference storageRef =
          storage.ref().child('highlight_videos/$highlightId');
      await storageRef.putFile(videoFile!);
      String videoUrl = await storageRef.getDownloadURL();

      // Create VideoModel
      VideoModel videoModel = VideoModel(
        highlightId: highlightId,
        highlightVideo: videoUrl,
        thumbnailUrl: "",
        time: time,
        userId: StaticData.userModel!.UserId, // Replace with the actual user ID
      );

      // Save video metadata to Firestore
      await _firestore
          .collection('highlight_videos')
          .doc(highlightId)
          .set(videoModel.toMap());

      print("Video uploaded with HighlightId: $highlightId");

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Video uploaded successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Reset video picker
      videoFile = null;
    } catch (e) {
      print("Error uploading video: $e");
      // Show error message
      Fluttertoast.showToast(
        msg: "Failed to upload video. Try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading = false;
    }
  }

  late VideoPlayerController controller;
  bool isPlaying = false;

  // Show video in dialog
  void showVideoDialog(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Play Video"),
          content: SizedBox(
            height: 400,
            child: VideoPlayerWidget(videoUrl: videoUrl),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.pause();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteVideo(BuildContext context, String highlightId) async {
    try {
      // Delete video metadata from Firestore
      await _firestore.collection('highlight_videos').doc(highlightId).delete();

      // Delete video file from Firebase Storage
      await storage.ref().child('highlight_videos/$highlightId').delete();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Video deleted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Error deleting video: $e");
      // Show error message
      Fluttertoast.showToast(
        msg: "Error deleting video: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  //////////////////timing set salon ////////////////////
  // Schedule data for each day
  Map<String, bool> officeStatus = {
    "Sunday": false,
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
  };

  Map<String, String> officeOpenTimes = {
    "Sunday": "Closed",
    "Monday": "5:00 PM",
    "Tuesday": "5:00 PM",
    "Wednesday": "5:00 PM",
    "Thursday": "5:00 PM",
    "Friday": "5:00 PM",
    "Saturday": "Closed",
  };

  Map<String, String> officeCloseTimes = {
    "Sunday": "Closed",
    "Monday": "9:00 PM",
    "Tuesday": "9:00 PM",
    "Wednesday": "9:00 PM",
    "Thursday": "9:00 PM",
    "Friday": "9:00 PM",
    "Saturday": "Closed",
  };

  // Firebase Firestore and Auth references
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveScheduleToFirebase(BuildContext context) async {
    try {
      // Set loading state to true to show the spinner
      isLoading = true;
      update(); // This will trigger the UI update

      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('office_schedules')
            .doc(StaticData.userModel!.UserId)
            .set({
          'officeStatus': officeStatus,
          'officeOpenTimes': officeOpenTimes,
          'officeCloseTimes': officeCloseTimes,
        });

        // Show success message as Toast
        Fluttertoast.showToast(
          msg: "Salon schedule updated successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        // Show error message as Toast (user not logged in)
        Fluttertoast.showToast(
          msg: "User not logged in!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Show error message as Toast
      Fluttertoast.showToast(
        msg: "Error saving schedule!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      // Set loading state to false to hide the spinner after the operation
      isLoading = false;
      update(); // This will trigger the UI update
    }
  }

  // Method to pick time for opening and closing
  Future<void> pickTime(
      BuildContext context, String day, bool isOpeningTime) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      String formattedTime = selectedTime.format(context);
      if (isOpeningTime) {
        officeOpenTimes[day] = formattedTime;
      } else {
        officeCloseTimes[day] = formattedTime;
      }
      update();
    }
  }

  void showScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text("Salon Schedule")),
        content: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0), // Animation for scaling
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale, // Apply the scale animation to the content
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('office_schedules')
                    .doc(StaticData.userModel!.UserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(child: Text('No schedule available'));
                  }

                  // Fetch schedule data
                  Map<String, dynamic> schedule =
                      snapshot.data!.data() as Map<String, dynamic>;
                  Map<String, bool> officeStatus =
                      Map<String, bool>.from(schedule['officeStatus']);
                  Map<String, String> officeOpenTimes =
                      Map<String, String>.from(schedule['officeOpenTimes']);
                  Map<String, String> officeCloseTimes =
                      Map<String, String>.from(schedule['officeCloseTimes']);

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (String day in officeStatus.keys)
                          ListTile(
                            title: Container(
                              width: 500,
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: officeStatus[day]!
                                ? Text(
                                    "Open: ${officeOpenTimes[day]} - Close: ${officeCloseTimes[day]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  )
                                : Text(
                                    "Closed",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  //////////////////////////////// product fetch /////////////

}
