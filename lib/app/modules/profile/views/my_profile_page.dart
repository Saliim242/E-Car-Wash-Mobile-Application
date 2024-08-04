import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewash/app/modules/profile/controllers/profile_controller.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../user/components/custom_buttom.dart';
import '../../user/controllers/user_controller.dart';
import '../components/custom_edit_text_feild.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final user = Get.find<UserController>();
  TextEditingController name = TextEditingController(
      text: "${Get.find<UserController>().user.name ?? ""}");
  TextEditingController email = TextEditingController(
      text: "${Get.find<UserController>().user.email ?? ""}");
  TextEditingController phone = TextEditingController(
      text: "${Get.find<UserController>().user.phone ?? ""}");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    // bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GetBuilder<UserController>(builder: (u) {
      return ModalProgressHUD(
        inAsyncCall: u.isUserprofileLoading,
        opacity: 0.5,
        progressIndicator: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            size: 80,
            color: BAppColor.kPrimaryColor,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                isDarkMode ? Theme.of(context).cardColor : Colors.white,
            elevation: 0,
            title: Text(
              "My Profile",
              style: style(
                fontSize: 16,
                color:
                    isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
              ),
            ),
            centerTitle: true,
            leading: backArrow(),
          ),
          body: GetBuilder<ProfileController>(
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(kPadding * 2),
                      Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: BAppColor.kSecondColor,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      width: 2.8,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: BAppColor.kSecondColor,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        width: 2.8,
                                      ),
                                      shape: BoxShape.circle,
                                      //controller.box.read(controller.keyValue)
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: controller.box2.read('custom') ==
                                                null
                                            ? CachedNetworkImageProvider(
                                                "https://www.pngmart.com/files/22/User-Avatar-Profile-PNG-Isolated-Transparent-Picture.png",
                                              )
                                            : Image.file(
                                                File(
                                                  controller.box2
                                                      .read('custom'),
                                                ),
                                                fit: BoxFit.cover,
                                              ).image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: 100,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //     border: Border.all(
                              //       color: BAppColor.kSecondColor,
                              //       strokeAlign: BorderSide.strokeAlignOutside,
                              //       width: 2.8,
                              //     ),
                              //     shape: BoxShape.circle,
                              //     //controller.box.read(controller.keyValue)
                              //     image: DecorationImage(
                              //       image: controller.box2.read('custom') == null
                              //           ? CachedNetworkImageProvider(
                              //               "${user.user.avatar ?? "https://www.pngmart.com/files/22/User-Avatar-Profile-PNG-Isolated-Transparent-Picture.png"}",
                              //             )
                              //           : Image.file(
                              //               File(
                              //                 controller.box2.read('custom'),
                              //               ),
                              //               fit: BoxFit.cover,
                              //             ).image,
                              //     ),
                              //   ),
                              // ),
                              Gap(kPadding - 8),
                              Text(
                                "${user.user.name}",
                                style: style(
                                  fontSize: 16,
                                  color: isDarkMode
                                      ? BAppColor.kbgColor.withOpacity(0.85)
                                      : BAppColor.kTextStyleColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Positioned(
                            top: 60,
                            right: 135,
                            child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? BAppColor.kCardDarkbgColor
                                    : BAppColor.kPrimaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  controller.getImage();
                                },
                                icon: Icon(
                                  IconlyLight.camera,
                                  color: BAppColor.kbgColor,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(kPadding * 3),
                      Text(
                        "Account Information",
                        style: style(
                          fontSize: 16,
                          color: BAppColor.kTextStyleColor,
                        ),
                      ),
                      Gap(kPadding * 2),
                      Text(
                        "FullName*",
                        style: style(
                          fontSize: 16,
                          color: isDarkMode
                              ? BAppColor.kbgColor
                              : BAppColor.kTextStyleColor,
                        ),
                      ),
                      Gap(kPadding),
                      CustomEditTextFeilds(
                        //  readOnly: true,
                        hintText: "Edit your name",
                        showPassowrd: false,
                        controller: name,
                        iconData: IconlyBroken.profile,
                      ),
                      Gap(kPadding),
                      Text(
                        "Email*",
                        style: style(
                          fontSize: 16,
                          color: isDarkMode
                              ? BAppColor.kbgColor
                              : BAppColor.kTextStyleColor,
                        ),
                      ),
                      Gap(kPadding),
                      CustomEditTextFeilds(
                        readOnly: true,
                        hintText: "Edit your email",
                        showPassowrd: false,
                        controller: email,
                        iconData: IconlyBroken.message,
                      ),
                      Gap(kPadding),
                      Text(
                        "Phone Number*",
                        style: style(
                          fontSize: 16,
                          color: isDarkMode
                              ? BAppColor.kbgColor
                              : BAppColor.kTextStyleColor,
                        ),
                      ),
                      Gap(kPadding),
                      CustomEditTextFeilds(
                        readOnly: false,
                        hintText: "Edit Your Phone Number",
                        showPassowrd: false,
                        controller: phone,
                        iconData: IconlyBroken.calling,
                        maxLines: null,
                      ),
                      Gap(kPadding * 2),
                      GetBuilder<UserController>(
                        builder: (us) {
                          return CustomButton(
                            icon: IconlyBroken.edit_square,
                            btnText: "Update Profile",
                            onTap: () {
                              us.updateUserProfile(
                                name: name.text.trim(),
                                email: email.text.trim(),
                                phone: phone.text.trim(),
                              );
                            },
                          );
                        },
                      ),
                      Gap(kPadding - 12),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
