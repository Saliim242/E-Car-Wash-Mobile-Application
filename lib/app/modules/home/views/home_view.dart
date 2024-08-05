import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../utils/constants/all_text_string.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/reusable_constants.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GetBuilder<HomeController>(
      builder: (ho) {
        return WillPopScope(
          // onWillPop: () async {
          //   final shouldPop = await ho.showExitConfirmationDialog(context);
          //   return shouldPop ?? false;
          // },
          onWillPop: ho.exit,
          child: Scaffold(
            appBar: ho.currentTab == 0
                ? AppBar(
                    elevation: 0,
                    backgroundColor: isDarkMode
                        ? BAppColor.kCardDarkbgColor
                        : BAppColor.kPrimaryColor,
                    automaticallyImplyLeading: false,
                    title: Text(
                      BAllTexts.appBarText,
                      style: style(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? BAppColor.kbgColor.withOpacity(0.65)
                            : BAppColor.kbgColor,
                      ),
                    ),
                    centerTitle: true,
                    actions: [
                      // IconButton(
                      //   onPressed: () {
                      //     ServicesThemes().changeThemeDynamically();
                      //   },
                      //   icon: Icon(Icons.dark_mode),
                      // ),
                    ],
                  )
                : null,
            body: GetBuilder<HomeController>(
              builder: (cont) {
                return cont.tabs[cont.currentTab];
              },
            ),
            bottomNavigationBar: GetBuilder<HomeController>(
              builder: (cont) {
                return NavigationBarTheme(
                  data: NavigationBarThemeData(
                    // backgroundColor:
                    //     BAppColor.kJtechPrimaryColor, //.withOpacity(0.02),
                    // // indicatorColor: BAppColor.kJtechPrimaryColor, //.withOpacity(0.1),
                    labelTextStyle: MaterialStateProperty.all(
                      style(
                        fontSize: 12,
                        color: isDarkMode
                            ? BAppColor.kbgColor.withOpacity(0.85)
                            : BAppColor.kTextStyleColor,
                      ),
                    ),
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: NavigationBar(
                    elevation: 0,

                    indicatorColor: isDarkMode
                        ? BAppColor.kSecondColor.withOpacity(0.25)
                        : BAppColor.kPrimaryColor.withOpacity(0.25),
                    height: 85,
                    //  surfaceTintColor: Colors.red,
                    backgroundColor: isDarkMode
                        ? BAppColor.kCardDarkbgColor
                        : Colors.white.withOpacity(0.75),
                    selectedIndex: cont.currentTab,
                    onDestinationSelected: (int index) =>
                        cont.updateCurrentTab(index),
                    destinations: [
                      NavigationDestination(
                        icon: Icon(IconlyBroken.home),
                        label: 'Home',
                        selectedIcon: Icon(
                          IconlyBold.home,
                          color: isDarkMode
                              ? BAppColor.kbgColor
                              : BAppColor.kPrimaryColor,
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(IconlyBroken.work),
                        label: 'Booking',
                        selectedIcon: Icon(
                          IconlyBold.work,
                          color: isDarkMode
                              ? BAppColor.kbgColor
                              : BAppColor.kPrimaryColor,
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(IconlyBroken.heart),
                        label: 'Favorites',
                        selectedIcon: Icon(
                          IconlyBold.heart,
                          color: isDarkMode
                              ? BAppColor.kbgColor
                              : BAppColor.kPrimaryColor,
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(IconlyBroken.profile),
                        label: 'Profile',
                        selectedIcon: Icon(
                          IconlyBold.profile,
                          color: isDarkMode
                              ? BAppColor.kbgColor
                              : BAppColor.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
