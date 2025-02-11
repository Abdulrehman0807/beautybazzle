import 'package:beautybazzle/model/signup_model.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _salonNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _youtubeController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();
  bool _isValidYouTubeLink(String url) {
    final youtubeRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/.+$',
      caseSensitive: false,
    );
    return youtubeRegex.hasMatch(url);
  }

  void _showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  bool _isValidFacebookLink(String url) {
    final facebookRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(facebook\.com)\/.+$',
      caseSensitive: false,
    );
    return facebookRegex.hasMatch(url);
  }

  bool _isValidInstagramLink(String url) {
    final instagramRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(instagram\.com|instagr\.am)\/.+$',
      caseSensitive: false,
    );
    return instagramRegex.hasMatch(url);
  }

  bool _isValidTikTokLink(String url) {
    final tiktokRegex = RegExp(
      r'^(https?\:\/\/)?(www\.)?(tiktok\.com)\/.+$',
      caseSensitive: false,
    );
    return tiktokRegex.hasMatch(url);
  }

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ImagePicker _picker = ImagePicker();
  XFile? _photo;
  bool _isLoadingSalon = false; // Loading indicator for salon picture
  bool _isLoadingProfile = false; // Loading indicator for profile picture

  // Upload Salon Picture
  Future<void> pickSalonPicture() async {
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
                _pickFromCamera(isSalon: true);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickFromGallery(isSalon: true);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  // Upload Profile Picture
  Future<void> pickProfilePicture() async {
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
                _pickFromCamera(isSalon: false);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickFromGallery(isSalon: false);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickFromGallery({required bool isSalon}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photo = pickedFile;
      });
      _uploadImage(isSalon: isSalon);
    }
  }

  Future<void> _pickFromCamera({required bool isSalon}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _photo = pickedFile;
      });
      _uploadImage(isSalon: isSalon);
    }
  }

  Future<void> _uploadImage({required bool isSalon}) async {
    if (_photo == null) return;

    setState(() {
      if (isSalon) {
        _isLoadingSalon = true;
      } else {
        _isLoadingProfile = true;
      }
    });

    try {
      final folder = isSalon ? 'salon_pictures' : 'profile_pictures';
      final ref = storage.ref().child('$folder/${_photo!.name}');

      // Upload the image to Firebase Storage
      await ref.putData(
        await _photo!.readAsBytes(),
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();

      // Save the URL to Firestore
      await _firestore.collection(folder).add({
        'imageUrl': downloadUrl,
        'uploadedAt': FieldValue.serverTimestamp(),
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
      setState(() {
        if (isSalon) {
          _isLoadingSalon = false;
        } else {
          _isLoadingProfile = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
            child: Center(
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height * 0.8,
                  width: width * 0.92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: pickProfilePicture,
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.blue[200],
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (_isLoadingProfile)
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Profile Picture",
                                  style: TextStyle(fontSize: width * 0.03),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: pickSalonPicture,
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.pink[200],
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (_isLoadingSalon)
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Salon Picture",
                                  style: TextStyle(fontSize: width * 0.03),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _salonNameController,
                          decoration: const InputDecoration(
                            labelText: "Salon Name",
                            hintText: "Enter your salon's name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Salon Name is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        child: TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            labelText: "Address",
                            hintText: "Enter your salon's address",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Address is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        child: TextFormField(
                          controller: _youtubeController,
                          decoration: InputDecoration(
                            labelText: "YouTube",
                            hintText: "Enter your YouTube link",
                            suffixIcon:
                                ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _youtubeController,
                              builder: (context, value, child) {
                                bool isFieldEmpty = value.text.isEmpty;
                                return IconButton(
                                  icon: Icon(
                                    isFieldEmpty ? Icons.paste : Icons.copy,
                                    size: width * 0.04,
                                  ),
                                  onPressed: isFieldEmpty
                                      ? () async {
                                          // Paste functionality
                                          ClipboardData? clipboardData =
                                              await Clipboard.getData(
                                                  Clipboard.kTextPlain);
                                          if (clipboardData != null &&
                                              clipboardData.text != null &&
                                              _isValidYouTubeLink(
                                                  clipboardData.text!)) {
                                            _youtubeController.text =
                                                clipboardData.text!;
                                          } else {
                                            _showToast(
                                              "Invalid YouTube link in clipboard!",
                                              Colors.red,
                                            );
                                          }
                                        }
                                      : () async {
                                          // Copy functionality
                                          if (_isValidYouTubeLink(value.text)) {
                                            Clipboard.setData(ClipboardData(
                                                text: value.text));
                                            _showToast(
                                                "YouTube link copied to clipboard!",
                                                Colors.green);
                                          } else {
                                            _showToast(
                                              "Invalid YouTube link!",
                                              Colors.red,
                                            );
                                          }
                                        },
                                );
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a YouTube link.";
                            }
                            if (!_isValidYouTubeLink(value)) {
                              return "Please enter a valid YouTube link.";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        child: TextFormField(
                          controller: _facebookController,
                          decoration: InputDecoration(
                            labelText: "Facebook",
                            hintText: "Enter your Facebook link",
                            suffixIcon:
                                ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _facebookController,
                              builder: (context, value, child) {
                                bool isFieldEmpty = value.text.isEmpty;
                                return IconButton(
                                  icon: Icon(
                                    isFieldEmpty ? Icons.paste : Icons.copy,
                                    size: width * 0.04,
                                  ),
                                  onPressed: isFieldEmpty
                                      ? () async {
                                          // Paste functionality
                                          ClipboardData? clipboardData =
                                              await Clipboard.getData(
                                                  Clipboard.kTextPlain);
                                          if (clipboardData != null &&
                                              clipboardData.text != null &&
                                              _isValidFacebookLink(
                                                  clipboardData.text!)) {
                                            _facebookController.text =
                                                clipboardData.text!;
                                          } else {
                                            _showToast(
                                              "Invalid Facebook link in clipboard!",
                                              Colors.red,
                                            );
                                          }
                                        }
                                      : () async {
                                          // Copy functionality
                                          if (_isValidFacebookLink(
                                              value.text)) {
                                            Clipboard.setData(ClipboardData(
                                                text: value.text));
                                            _showToast(
                                                "Facebook link copied to clipboard!",
                                                Colors.green);
                                          } else {
                                            _showToast(
                                              "Invalid Facebook link!",
                                              Colors.red,
                                            );
                                          }
                                        },
                                );
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a Facebook link.";
                            }
                            if (!_isValidFacebookLink(value)) {
                              return "Please enter a valid Facebook link.";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        child: TextFormField(
                          controller: _instagramController,
                          decoration: InputDecoration(
                            labelText: "Instagram",
                            hintText: "Enter your Instagram link",
                            suffixIcon:
                                ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _instagramController,
                              builder: (context, value, child) {
                                bool isFieldEmpty = value.text.isEmpty;
                                return IconButton(
                                  icon: Icon(
                                    isFieldEmpty ? Icons.paste : Icons.copy,
                                    size: width * 0.04,
                                  ),
                                  onPressed: isFieldEmpty
                                      ? () async {
                                          // Paste functionality
                                          ClipboardData? clipboardData =
                                              await Clipboard.getData(
                                                  Clipboard.kTextPlain);
                                          if (clipboardData != null &&
                                              clipboardData.text != null &&
                                              _isValidInstagramLink(
                                                  clipboardData.text!)) {
                                            _instagramController.text =
                                                clipboardData.text!;
                                          } else {
                                            _showToast(
                                              "Invalid Instagram link in clipboard!",
                                              Colors.red,
                                            );
                                          }
                                        }
                                      : () async {
                                          // Copy functionality
                                          if (_isValidInstagramLink(
                                              value.text)) {
                                            Clipboard.setData(ClipboardData(
                                                text: value.text));
                                            _showToast(
                                                "Instagram link copied to clipboard!",
                                                Colors.green);
                                          } else {
                                            _showToast(
                                              "Invalid Instagram link!",
                                              Colors.red,
                                            );
                                          }
                                        },
                                );
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter an Instagram link.";
                            }
                            if (!_isValidInstagramLink(value)) {
                              return "Please enter a valid Instagram link.";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        child: TextFormField(
                          controller: _tiktokController,
                          decoration: InputDecoration(
                            labelText: "TikTok",
                            hintText: "Enter your TikTok link",
                            suffixIcon:
                                ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _tiktokController,
                              builder: (context, value, child) {
                                bool isFieldEmpty = value.text.isEmpty;
                                return IconButton(
                                  icon: Icon(
                                    isFieldEmpty ? Icons.paste : Icons.copy,
                                    size: width * 0.04,
                                  ),
                                  onPressed: isFieldEmpty
                                      ? () async {
                                          // Paste functionality
                                          ClipboardData? clipboardData =
                                              await Clipboard.getData(
                                                  Clipboard.kTextPlain);
                                          if (clipboardData != null &&
                                              clipboardData.text != null &&
                                              _isValidTikTokLink(
                                                  clipboardData.text!)) {
                                            _tiktokController.text =
                                                clipboardData.text!;
                                          } else {
                                            _showToast(
                                              "Invalid TikTok link in clipboard!",
                                              Colors.red,
                                            );
                                          }
                                        }
                                      : () async {
                                          // Copy functionality
                                          if (_isValidTikTokLink(value.text)) {
                                            Clipboard.setData(ClipboardData(
                                                text: value.text));
                                            _showToast(
                                                "TikTok link copied to clipboard!",
                                                Colors.green);
                                          } else {
                                            _showToast(
                                              "Invalid TikTok link!",
                                              Colors.red,
                                            );
                                          }
                                        },
                                );
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a TikTok link.";
                            }
                            if (!_isValidTikTokLink(value)) {
                              return "Please enter a valid TikTok link.";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.85,
                        child: TextFormField(
                          controller: _aboutMeController,
                          maxLines: null, // Allows multi-line input
                          decoration: InputDecoration(
                            labelText: "About Me",
                            hintText: "Tell us about yourself",
                          ),
                          onChanged: (value) {
                            // Split the input by whitespace and filter out empty words
                            List<String> words =
                                value.trim().split(RegExp(r'\s+'));
                            if (words.length > 500) {
                              // If word count exceeds 500, trim the extra words
                              _aboutMeController.text =
                                  words.sublist(0, 500).join(' ');
                              _aboutMeController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _aboutMeController.text.length),
                              );
                              Fluttertoast.showToast(
                                msg: "Word limit is 500!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () async {
                            String salonName = _salonNameController.text.trim();
                            String address = _addressController.text.trim();
                            String youtube = _youtubeController.text.trim();
                            String facebook = _facebookController.text.trim();
                            String instagram = _instagramController.text.trim();
                            String tiktok = _tiktokController.text.trim();
                            String aboutMe = _aboutMeController.text.trim();

                            try {
                              String userId = StaticData.userModel!.UserId;
                              print(userId);

                              // Update the user's profile in Firestore
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(userId)
                                  .update({
                                'SalonName': salonName,
                                'Address': address,
                                'YouTube': youtube,
                                'Facebook': facebook,
                                'Instagram': instagram,
                                'TikTok': tiktok,
                                'AboutMe': aboutMe,
                              });

                              // Fetch updated user data to confirm changes
                              QuerySnapshot snapshot = await FirebaseFirestore
                                  .instance
                                  .collection("Users")
                                  .where("UserId", isEqualTo: userId)
                                  .get();

                              if (snapshot.docs.isNotEmpty) {
                                // If user data is successfully updated, map it to the model
                                UserModels model = UserModels.fromMap(
                                    snapshot.docs[0].data()
                                        as Map<String, dynamic>);
                                StaticData.userModel = model;

                                // Show success toast
                                Fluttertoast.showToast(
                                  msg: "Profile updated successfully!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );

                                // Navigate back to the previous screen
                                Navigator.pop(context);
                              } else {
                                // Show error toast if snapshot is empty
                                Fluttertoast.showToast(
                                  msg: "Error: Profile not updated. Try again!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            } catch (e) {
                              // Show error toast for exceptions
                              Fluttertoast.showToast(
                                msg: "Error updating profile: $e",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                                color: Colors.pink[200],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    )));
  }
}
