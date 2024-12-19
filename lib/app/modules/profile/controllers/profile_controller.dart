import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../components/pick_image.dart';

class ProfileController extends GetxController {
  File? imageFile;
  final picker = ImagePicker();
  final box2 = GetStorage();
  final keyValue = 'user';
  final box = GetStorage();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor:
          Get.isDarkMode ? BAppColor.kCardDarkbgColor : Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (builder) {
        return Card(
          color:
              Get.isDarkMode ? BAppColor.kCardDarkbgColor : BAppColor.kbgColor,
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height / 5.2,
            height: MediaQuery.of(context).size.height * .26,
            // color: Get.isDarkMode
            //     ? BAppColor.kJtechPrimaryColor
            //     : BAppColor.kbgColor,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  "Pick your image from your gallery 🤳 or take a capture by your self 📸",
                  textAlign: TextAlign.center,
                  style: style(
                    fontSize: 16,
                    color: Get.isDarkMode
                        ? BAppColor.kbgColor
                        : BAppColor.kTextStyleColor,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PickImage(
                        pickIconImage: IconlyBroken.image,
                        pickImageTitle: "Gellary",
                        onTap: () {
                          _imgFromGallery();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: PickImage(
                        pickIconImage: IconlyBroken.camera,
                        pickImageTitle: "Camera",
                        onTap: () {
                          _imgFromCamera();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 100)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    )
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      compressQuality: 100,
      //cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: BAppColor.kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: "Image Cropper",
        )
      ],
    );
    if (croppedFile != null) {
      imageCache.clear();
      imageFile = File(croppedFile.path);
      box2.write("custom", imageFile!.path);
      update();
      // reload();
    }
  }

  void getImage() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    if (statuses[Permission.camera]!.isGranted) {
      showImagePicker(Get.context!);
    } else {
      print('no permission provided');
    }
  }

  // Contacts
  callPhone(String phone) async {
    PermissionStatus status = await Permission.phone.request();
    if (status.isGranted) {
      try {
        String message = 'tel:$phone';

        await launchUrl(Uri.parse(message));
      } catch (e) {
        print('on what\'s app ERROR:$e');
        showToast(
          message: "${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: BAppColor.kCheckOutInActiveBgColor,
          textColor: BAppColor.kCheckOutActiveTextColor,
        );
      }
    } else if (status.isDenied) {
      showToast(
        message: "Permission is denied Please Grant to the permissin.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    }
  }

  void callWhatsApp(String number) async {
    try {
      String message = 'Assalamu alaykum!';
      var whatsappUrl = "whatsapp://send?phone=$number&text=$message";

      await launchUrl(Uri.parse(whatsappUrl));
    } catch (e) {
      print('on what\'s app ERROR:$e');
      showToast(
        message: "${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    }
  }

  void callMail(String email) async {
    try {
      String message = 'Assalamu alaykum!';
      var mailto = "mailto:$email?subject=&body=$message";

      await launchUrl(Uri.parse(mailto));
    } catch (e) {
      print('on what\'s app ERROR:$e');
      showToast(
        message: "${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
