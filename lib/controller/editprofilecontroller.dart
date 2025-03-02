import 'dart:io';
import 'package:beautybazzle/model/addoffer.dart';
import 'package:beautybazzle/model/addproduct.dart';
import 'package:beautybazzle/model/addservices.dart';
import 'package:beautybazzle/model/addspecialist.dart';
import 'package:beautybazzle/model/addwork.dart';
import 'package:beautybazzle/model/signup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final ImagePicker picker = ImagePicker();
  String? offerPicUrl;
  String? productPicUrl;
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
      Fluttertoast.showToast(
        msg: '${isSalon ? "Salon" : "Profile"} image uploaded successfully!',
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
        msg: 'Failed to upload ${isSalon ? "salon" : "profile"} image!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
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
              child: AlertDialog(
                title: const Center(child: Text("Add a Best Service")),
                content: Form(
                  key: formKey,
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
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: servicePic != null
                                  ? Image.file(
                                      File(servicePic!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                            ),
                            if (isLoadingService)
                              const CircularProgressIndicator(
                                color: Colors.white,
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
              ),
            );
          },
        );
      },
    );
  }
////////////////////// update service//////////////////

  void showUpdateServiceDialog(BuildContext context, ServiceModel model) {
    serviceNameController.text = model.serviceName ?? '';
    serviceDescriptionController.text = model.serviceDescription ?? '';

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
              child: AlertDialog(
                title: const Text('Update Service'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 500,
                      child: TextField(
                        controller: serviceNameController,
                        decoration:
                            const InputDecoration(hintText: 'Service Name'),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: serviceDescriptionController,
                      decoration: const InputDecoration(
                          hintText: 'Service Description'),
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (serviceNameController.text.isNotEmpty &&
                            serviceDescriptionController.text.isNotEmpty) {
                          // Update the service in Firestore
                          await updateServiceInFirestore(
                            model.serviceId,
                            serviceNameController.text,
                            serviceDescriptionController.text,
                          );
                          Navigator.of(dc).pop();
                        } else {
                          // Handle empty field case
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all fields')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.pink[200], // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 130, // Horizontal padding
                          vertical: 10, // Vertical padding
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 20, // Font size
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
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

  // Function to update the service details in Firestore
  Future<void> updateServiceInFirestore(
    String serviceId,
    String newServiceName,
    String newDescription,
  ) async {
    try {
      // Update the service data in Firestore
      await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .update({
        'serviceName': newServiceName,
        'serviceDescription': newDescription,
      });

      // Show success message
      print("Service updated successfully!");
      Fluttertoast.showToast(
        msg: 'Service updated successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      // Show error message if update fails
      print("Error updating service: $e");
      Fluttertoast.showToast(
        msg: 'Error updating service',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
              child: AlertDialog(
                title: const Center(child: Text("Add a Best Product")),
                content: Form(
                  key: formKey,
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
                      SizedBox(height: height * 0.03),

                      // Image Picker
                      InkWell(
                        onTap: () => pickProductImage(context),
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
                              child: productPic != null
                                  ? Image.file(
                                      File(productPic!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                            ),
                            if (isLoadingProduct)
                              const CircularProgressIndicator(
                                color: Colors.white,
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
              ),
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
              child: AlertDialog(
                title: const Center(child: Text("Add a Best Specialist")),
                content: SingleChildScrollView(
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
                              child: specialistPic != null
                                  ? Image.file(
                                      File(specialistPic!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                            ),
                            if (isLoadingSpecialist)
                              const CircularProgressIndicator(
                                color: Colors.white,
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
              ),
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
              child: AlertDialog(
                title: const Center(child: Text("Add Best Work")),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Work Type Field
                      Container(
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: recentWorkPic != null
                                  ? Image.file(
                                      File(recentWorkPic!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.black45,
                                    ),
                            ),
                            if (isLoadingWork)
                              const CircularProgressIndicator(
                                color: Colors.white,
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
              ),
            );
          },
        );
      },
    );
  }

  //////////////////////////video upload ////////////////////////
  File? videoFile;
  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile = File(pickedFile.path);
      update();
    }
  }

  Future<void> uploadVideo(BuildContext context) async {
    if (videoFile == null) return;

    isloadingvideo = true;
    update();

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('videos/${DateTime.now().toIso8601String()}');
      await ref.putFile(videoFile!);
      final downloadUrl = await ref.getDownloadURL();

      print('Video uploaded: $downloadUrl');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video uploaded successfully!')),
      );
    } catch (e) {
      print('Error uploading video: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload video. Try again.')),
      );
    } finally {
      isloadingvideo = false;
      update();
    }
  }
}
