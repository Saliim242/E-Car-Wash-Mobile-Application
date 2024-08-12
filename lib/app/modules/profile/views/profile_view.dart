import 'dart:async';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewash/app/modules/profile/views/about_page.dart';
import 'package:ewash/app/modules/profile/views/my_profile_page.dart';
import 'package:ewash/utils/theme/theme_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/reusable_constants.dart';
import '../../user/controllers/user_controller.dart';
import '../components/general_setting_card.dart';
import '../controllers/profile_controller.dart';
import 'customer_care.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    // bool isPortrait = BReusableConstants.isPortrait(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "User Profile",
          style: style(
            fontSize: 16,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(
        builder: (prof) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(kPadding * 2),
                  // Image Profile and User name
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isDarkMode
                          ? BAppColor.kCardDarkbgColor
                          : Colors.white,
                    ),
                    child: GetBuilder<ProfileController>(
                      builder: (controller) {
                        return Column(
                          children: [
                            Gap(kPadding * 2),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: BAppColor.kSecondColor,
                                  //   strokeAlign: BorderSide.strokeAlignOutside,
                                  //   width: 2.8,
                                  // ),
                                  shape: BoxShape.circle,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //   color: BAppColor.kSecondColor,
                                      //   strokeAlign:
                                      //       BorderSide.strokeAlignOutside,
                                      //   width: 2.8,
                                      // ),
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
                                          image:
                                              controller.box2.read('custom') ==
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
                              ),
                            ),
                            Gap(kPadding - 6),
                            Text(
                              "${prof.user.name}",
                              style: style(
                                fontSize: 16,
                                color: isDarkMode
                                    ? BAppColor.kbgColor
                                    : BAppColor.kTextStyleColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Gap(10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? BAppColor.kDarkSecondColor
                                        .withOpacity(0.65)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${prof.user.email}",
                                style: style(
                                  fontSize: 16,
                                  color: isDarkMode
                                      ? BAppColor.kbgColor.withOpacity(0.65)
                                      : BAppColor.kTextStyleColor
                                          .withOpacity(0.65),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Gap(kPadding + 10),
                  // Personal Information Data
                  Container(
                    padding: EdgeInsets.only(left: 25, top: 20, bottom: 15),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? BAppColor.kCardDarkbgColor
                          : Colors
                              .white, //Color(0xffefefef), //.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: style(
                            // fontFamily: "Metrophobic",
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? Color(0xffe5e5e5)
                                : BAppColor.kTextStyleColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        GeneralInSettingCard(
                          title: '${prof.user.name ?? ""}',
                          subtitle: "Customer Full Name",
                          icon: IconlyBroken.profile,
                          onTap: () {},
                        ),
                        GeneralInSettingCard(
                          title: '${prof.user.email ?? ""}',
                          subtitle: "Customer Email address",
                          icon: IconlyBroken.message,
                          onTap: () {},
                        ),
                        GeneralInSettingCard(
                          title: '${prof.user.phone ?? ""}',
                          subtitle: "Customer Telephone Number",
                          icon: IconlyBroken.calling,
                          onTap: () {},
                        ),
                        // GeneralInSettingCard(
                        //   title: '${prof.user.role ?? ""}',
                        //   subtitle:
                        //       "Your role defines your app access and features.",
                        //   icon: IconlyBroken.category,
                        //   onTap: () {},
                        // ),
                        // GeneralInSettingCard(
                        //   title: '${prof.user.status ?? ""}',
                        //   subtitle: "Customer status",
                        //   icon: Iconsax.tick_square,
                        //   onTap: () {},
                        // ),
                      ],
                    ),
                  ),
                  Gap(kPadding + 10),
                  // Other Settings
                  Container(
                    padding: EdgeInsets.only(left: 25, top: 20, bottom: 15),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? BAppColor.kCardDarkbgColor
                          : Colors
                              .white, //Color(0xffefefef), //.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Information',
                          style: style(
                            // fontFamily: "Metrophobic",
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? Color(0xffe5e5e5)
                                : BAppColor.kTextStyleColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        GeneralInSettingCard(
                          title: 'My Profile',
                          subtitle: "View and edit your personal information.",
                          icon: IconlyBroken.profile,
                          onTap: () {
                            Get.to(
                              () => MyProfilePage(),
                              transition: Transition.fade,
                            );
                          },
                          trailing: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              IconlyBroken.arrow_right_2,
                              color: isDarkMode
                                  ? BAppColor.kbgColor.withOpacity(0.75)
                                  : BAppColor.kTextStyleColor.withOpacity(0.65),
                            ),
                          ),
                        ),
                        // GeneralInSettingCard(
                        //   title: 'Booking Detail',
                        //   subtitle:
                        //       "View your booking history and future reservations.",
                        //   icon: IconlyBroken.calendar,
                        //   trailing: Container(
                        //     margin: EdgeInsets.only(right: 10),
                        //     child: Icon(
                        //       IconlyBroken.arrow_right_2,
                        //       color: isDarkMode
                        //           ? BAppColor.kbgColor.withOpacity(0.75)
                        //           : BAppColor.kTextStyleColor.withOpacity(0.65),
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     Get.to(
                        //       () => BookingView(),
                        //       transition: Transition.fade,
                        //     );
                        //   },
                        // ),
                        GeneralInSettingCard(
                          title: 'Customer Care',
                          subtitle:
                              "Get support and assistance for any queries or issues.",
                          icon: IconlyBroken.calling,
                          trailing: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              IconlyBroken.arrow_right_2,
                              color: isDarkMode
                                  ? BAppColor.kbgColor.withOpacity(0.75)
                                  : BAppColor.kTextStyleColor.withOpacity(0.65),
                            ),
                          ),
                          onTap: () {
                            Get.to(
                              () => CustomerCarePage(),
                              transition: Transition.fade,
                            );
                            // user.showLogoutConfirmationDialog(
                            //   context,
                            //   btnOkOnPress: () {
                            //     user.logOut(kStudentInfo, context);
                            //   },
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                  // General Setting Page
                  Gap(kPadding + 10),
                  Container(
                    padding: EdgeInsets.only(left: 25, top: 20, bottom: 15),
                    // height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? BAppColor.kCardDarkbgColor
                          : Colors
                              .white, //Color(0xffefefef), //.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GENERAL SETTINGS'.tr,
                          style: TextStyle(
                            fontFamily: "Metrophobic",
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? Color(0xffe5e5e5)
                                : BAppColor.kTextStyleColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        GeneralInSettingCard(
                          trailing: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              IconlyBroken.arrow_right_2,
                              color: isDarkMode
                                  ? BAppColor.kbgColor.withOpacity(0.75)
                                  : BAppColor.kTextStyleColor.withOpacity(0.65),
                            ),
                          ),
                          title: 'About Us',
                          subtitle: "Learn more about us E-wash ",
                          icon: Icons.code,
                          onTap: () {
                            Get.to(
                              () => AboutPage(),
                              transition: Transition.fade,
                            );
                          },
                        ),
                        GeneralInSettingCard(
                          subtitle:
                              "Switch to dark mode , for more comfortble experience.",
                          title: 'Dark Mode'.tr,
                          icon: Get.isDarkMode
                              ? CupertinoIcons.moon_zzz
                              : CupertinoIcons.cloud_moon_rain,
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Get.isDarkMode
                                  ? Icons.toggle_on
                                  : Icons.toggle_off,
                              color: Get.isDarkMode
                                  ? BAppColor.kSecondColor
                                  : BAppColor.kPrimaryColor.withOpacity(0.5),
                              size: 40,
                            ),
                          ),
                          onTap: () {
                            ServicesThemes().changeThemeDynamically();
                            // setState(() {
                            //   Get.isDarkMode
                            //       ? theme.setLightMode()
                            //       : theme.setDarkMode();
                            // });
                          },
                        ),
                        GeneralInSettingCard(
                          title: 'Logout'.tr,
                          subtitle: "Sign out of your account securely.",
                          icon: IconlyBroken.logout,
                          onTap: () {
                            prof.showLogoutConfirmationDialog(
                              context: context,
                              isDarkMode: isDarkMode,
                              onConfirm: () {
                                prof.logOut();
                              },
                            );

                            // user.showLogoutConfirmationDialog(
                            //   context,
                            //   btnOkOnPress: () {
                            //     user.logOut(kStudentInfo, context);
                            //   },
                            // );
                          },
                        ),
                        // GeneralInSettingCard(
                        //   title: 'Delete Acount',
                        //   subtitle: "Permanently remove your account and data.",
                        //   icon: IconlyBroken.delete,
                        //   color: BAppColor.kCheckOutActiveTextColor,
                        //   bgcolor: BAppColor.kCheckOutInActiveBgColor,
                        //   onTap: () {
                        //     // user.showLogoutConfirmationDialog(
                        //     //   context,
                        //     //   btnOkOnPress: () {
                        //     //     user.logOut(kStudentInfo, context);
                        //     //   },
                        //     // );
                        //   },
                        // ),
                      ],
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.017),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // Get.find<UserController>().getUser();
  }
}
