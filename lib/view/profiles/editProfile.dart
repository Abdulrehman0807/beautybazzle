import 'package:beautybazzle/controller/profile/editprofilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final ProfileController obj = ProfileController.to;

    obj.nameController.text = obj.usermodel?.name ?? '';
    obj.salonNameController.text = obj.salonmodel?.SalonName ?? '';

    obj.addressController.text = obj.usermodel?.Address ?? '';
    obj.youtubeController.text = obj.usermodel?.YouTube ?? '';
    obj.facebookController.text = obj.usermodel?.Facebook ?? '';
    obj.instagramController.text = obj.usermodel?.Instagram ?? '';
    obj.tiktokController.text = obj.usermodel?.TikTok ?? '';
    obj.aboutMeController.text = obj.usermodel?.AboutMe ?? '';
    obj.salonDescriptionController.text =
        obj.salonmodel?.salonDescription ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<ProfileController>(
        builder: (obj) {
          return Stack(
            children: [
              Form(
                key: formKey,
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.8, end: 1.0),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                    builder: (context, double scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          height: height,
                          width: width,
                          color: Colors.white,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      obj.pickProfilePicture(context);
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 35,
                                              backgroundImage: obj.usermodel
                                                              ?.ProfilePicture !=
                                                          null &&
                                                      obj
                                                          .usermodel!
                                                          .ProfilePicture!
                                                          .isNotEmpty
                                                  ? NetworkImage(obj.usermodel!
                                                      .ProfilePicture!)
                                                  : null,
                                              backgroundColor: Colors.blue[200],
                                              child: obj.usermodel
                                                              ?.ProfilePicture ==
                                                          null ||
                                                      obj
                                                          .usermodel!
                                                          .ProfilePicture!
                                                          .isEmpty
                                                  ? const Icon(
                                                      Icons.camera_alt,
                                                      size: 30,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                            ),
                                            if (obj.isLoadingProfile)
                                              const SpinKitSpinningLines(
                                                color: Colors.pink,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Profile Picture",
                                          style:
                                              TextStyle(fontSize: width * 0.03),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await obj.pickSalonPicture(context);
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 35,
                                              backgroundImage: obj.salonmodel
                                                              ?.SalonPicture !=
                                                          null &&
                                                      obj
                                                          .salonmodel!
                                                          .SalonPicture!
                                                          .isNotEmpty
                                                  ? NetworkImage(obj.salonmodel!
                                                      .SalonPicture!)
                                                  : null,
                                              backgroundColor: Colors.pink[200],
                                              child: obj.salonmodel
                                                              ?.SalonPicture ==
                                                          null ||
                                                      obj.salonmodel!
                                                          .SalonPicture!.isEmpty
                                                  ? const Icon(
                                                      Icons.camera_alt,
                                                      size: 30,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                            ),
                                            if (obj.isLoadingSalon)
                                              const SpinKitSpinningLines(
                                                color: Colors.pink,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Salon Picture",
                                          style:
                                              TextStyle(fontSize: width * 0.03),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.02),
                              Container(
                                height: height * 0.09,
                                width: width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.4,
                                      child: TextFormField(
                                        controller: obj.nameController,
                                        decoration: const InputDecoration(
                                          labelText: " Name",
                                          hintText: "Enter your name",
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return " Name is required";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.45,
                                      child: TextFormField(
                                        controller: obj.salonNameController,
                                        decoration: const InputDecoration(
                                          labelText: "Salon Name",
                                          hintText: "Enter your salon's name",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: obj.addressController,
                                decoration: const InputDecoration(
                                  labelText: "Address",
                                  hintText: "Enter your address",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Address is required";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: obj.youtubeController,
                                decoration: InputDecoration(
                                  labelText: "YouTube",
                                  hintText: "Enter your YouTube link",
                                  suffixIcon:
                                      ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: obj.youtubeController,
                                    builder: (context, value, child) {
                                      bool isFieldEmpty = value.text.isEmpty;
                                      return IconButton(
                                        icon: Icon(
                                          isFieldEmpty
                                              ? Icons.paste
                                              : Icons.copy,
                                          size: width * 0.04,
                                        ),
                                        onPressed: isFieldEmpty
                                            ? () async {
                                                ClipboardData? clipboardData =
                                                    await Clipboard.getData(
                                                        Clipboard.kTextPlain);
                                                if (clipboardData != null &&
                                                    clipboardData.text !=
                                                        null &&
                                                    obj.isValidYouTubeLink(
                                                        clipboardData.text!)) {
                                                  obj.youtubeController.text =
                                                      clipboardData.text!;
                                                } else {
                                                  obj.showToast(
                                                    "Invalid YouTube link in clipboard!",
                                                    Colors.red,
                                                  );
                                                }
                                              }
                                            : () async {
                                                if (obj.isValidYouTubeLink(
                                                    value.text)) {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: value.text));
                                                  obj.showToast(
                                                    "YouTube link copied to clipboard!",
                                                    Colors.green,
                                                  );
                                                } else {
                                                  obj.showToast(
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
                                  if (!obj.isValidYouTubeLink(value)) {
                                    return "Please enter a valid YouTube link.";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.url,
                              ),
                              TextFormField(
                                controller: obj.facebookController,
                                decoration: InputDecoration(
                                  labelText: "Facebook",
                                  hintText: "Enter your Facebook link",
                                  suffixIcon:
                                      ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: obj.facebookController,
                                    builder: (context, value, child) {
                                      bool isFieldEmpty = value.text.isEmpty;
                                      return IconButton(
                                        icon: Icon(
                                          isFieldEmpty
                                              ? Icons.paste
                                              : Icons.copy,
                                          size: width * 0.04,
                                        ),
                                        onPressed: isFieldEmpty
                                            ? () async {
                                                ClipboardData? clipboardData =
                                                    await Clipboard.getData(
                                                        Clipboard.kTextPlain);
                                                if (clipboardData != null &&
                                                    clipboardData.text !=
                                                        null &&
                                                    obj.isValidFacebookLink(
                                                        clipboardData.text!)) {
                                                  obj.facebookController.text =
                                                      clipboardData.text!;
                                                } else {
                                                  obj.showToast(
                                                    "Invalid Facebook link in clipboard!",
                                                    Colors.red,
                                                  );
                                                }
                                              }
                                            : () async {
                                                if (obj.isValidFacebookLink(
                                                    value.text)) {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: value.text));
                                                  obj.showToast(
                                                    "Facebook link copied to clipboard!",
                                                    Colors.green,
                                                  );
                                                } else {
                                                  obj.showToast(
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
                                  if (!obj.isValidFacebookLink(value)) {
                                    return "Please enter a valid Facebook link.";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.url,
                              ),
                              TextFormField(
                                controller: obj.instagramController,
                                decoration: InputDecoration(
                                  labelText: "Instagram",
                                  hintText: "Enter your Instagram link",
                                  suffixIcon:
                                      ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: obj.instagramController,
                                    builder: (context, value, child) {
                                      bool isFieldEmpty = value.text.isEmpty;
                                      return IconButton(
                                        icon: Icon(
                                          isFieldEmpty
                                              ? Icons.paste
                                              : Icons.copy,
                                          size: width * 0.04,
                                        ),
                                        onPressed: isFieldEmpty
                                            ? () async {
                                                ClipboardData? clipboardData =
                                                    await Clipboard.getData(
                                                        Clipboard.kTextPlain);
                                                if (clipboardData != null &&
                                                    clipboardData.text !=
                                                        null &&
                                                    obj.isValidInstagramLink(
                                                        clipboardData.text!)) {
                                                  obj.instagramController.text =
                                                      clipboardData.text!;
                                                } else {
                                                  obj.showToast(
                                                    "Invalid Instagram link in clipboard!",
                                                    Colors.red,
                                                  );
                                                }
                                              }
                                            : () async {
                                                if (obj.isValidInstagramLink(
                                                    value.text)) {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: value.text));
                                                  obj.showToast(
                                                    "Instagram link copied to clipboard!",
                                                    Colors.green,
                                                  );
                                                } else {
                                                  obj.showToast(
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
                                  if (!obj.isValidInstagramLink(value)) {
                                    return "Please enter a valid Instagram link.";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.url,
                              ),
                              TextFormField(
                                controller: obj.tiktokController,
                                decoration: InputDecoration(
                                  labelText: "TikTok",
                                  hintText: "Enter your TikTok link",
                                  suffixIcon:
                                      ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: obj.tiktokController,
                                    builder: (context, value, child) {
                                      bool isFieldEmpty = value.text.isEmpty;
                                      return IconButton(
                                        icon: Icon(
                                          isFieldEmpty
                                              ? Icons.paste
                                              : Icons.copy,
                                          size: width * 0.04,
                                        ),
                                        onPressed: isFieldEmpty
                                            ? () async {
                                                ClipboardData? clipboardData =
                                                    await Clipboard.getData(
                                                        Clipboard.kTextPlain);
                                                if (clipboardData != null &&
                                                    clipboardData.text !=
                                                        null &&
                                                    obj.isValidTikTokLink(
                                                        clipboardData.text!)) {
                                                  obj.tiktokController.text =
                                                      clipboardData.text!;
                                                } else {
                                                  obj.showToast(
                                                    "Invalid TikTok link in clipboard!",
                                                    Colors.red,
                                                  );
                                                }
                                              }
                                            : () async {
                                                if (obj.isValidTikTokLink(
                                                    value.text)) {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: value.text));
                                                  obj.showToast(
                                                    "TikTok link copied to clipboard!",
                                                    Colors.green,
                                                  );
                                                } else {
                                                  obj.showToast(
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
                                  if (!obj.isValidTikTokLink(value)) {
                                    return "Please enter a valid TikTok link.";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.url,
                              ),
                              const SizedBox(height: 2),
                              TextFormField(
                                controller: obj.aboutMeController,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  labelText: "About Me",
                                  hintText: "Tell us about yourself",
                                ),
                              ),
                              const SizedBox(height: 2),
                              TextFormField(
                                controller: obj.salonDescriptionController,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  labelText: "About Salon",
                                  hintText:
                                      "Tell us about your Salon Description",
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  await obj.saveProfileData(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 150, vertical: 10),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              obj.isLoading
                  ? Container(
                      height: height,
                      width: width,
                      color: Colors.pink.withOpacity(0.3),
                      child: Center(
                          child: SpinKitSpinningLines(color: Colors.pink)),
                    )
                  : SizedBox()
            ],
          );
        },
      ),
    );
  }
}
