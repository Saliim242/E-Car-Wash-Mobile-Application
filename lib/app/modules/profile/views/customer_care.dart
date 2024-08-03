import 'package:ewash/app/modules/profile/controllers/profile_controller.dart';
import 'package:ewash/utils/constants/api_or_keys_constants.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../home/controllers/home_controller.dart';

class CustomerCarePage extends StatefulWidget {
  const CustomerCarePage({super.key});

  @override
  State<CustomerCarePage> createState() => _CustomerCarePageState();
}

class _CustomerCarePageState extends State<CustomerCarePage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
        leading: backArrow(),
        elevation: 0,
        title: Text(
          "Customer Care",
          style: style(
            fontSize: 16,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (cont) {
          return GetBuilder<ProfileController>(
            builder: (prof) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    children: [
                      Gap(kPadding * 2),
                      Center(
                        child: Text(
                          "How can we assist you today?",
                          style: style(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? BAppColor.kbgColor
                                : BAppColor.kTextStyleColor,
                          ),
                        ),
                      ),
                      Gap(kPadding - 5),
                      Center(
                        child: Text(
                          "Reach out to us with any inquiries or issues, and we'll provide the support you need.",
                          style: style(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? BAppColor.kbgColor
                                : BAppColor.kTextStyleColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap(kPadding * 3),
                      HelpCardd(
                        icon: IconlyBroken.calling,
                        title: "Call",
                        subtitle:
                            "Speak directly with our support team for immediate assistance.",
                        onTap: () {
                          prof.callPhone("252613264540");
                          // final home = Get.find<HomeController>();
                          // home.callPhone('252615180495');
                        },
                      ),
                      Gap(kPadding),
                      HelpCardd(
                          title: "E-mail",
                          // color: Colors.cyan,
                          icon: IconlyBroken.message,
                          subtitle:
                              "Send us a detailed message, and we'll get back to you promptly.",
                          onTap: () {
                            prof.callMail("salim7442@gmail.com");
                          }
                          // cont.callMail("info@baidoauniversity.edu.so"),
                          ),
                      Gap(kPadding),
                      HelpCardd(
                        onTap: () {
                          prof.callWhatsApp('252613264540');
                        },
                        title: "Chat",
                        color: Colors.green,
                        icon: LineIcons.whatSApp,
                        subtitle:
                            "Chat with our support agents for quick and convenient help.",
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HelpCardd extends StatelessWidget {
  const HelpCardd({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.onTap,
  });
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: kPadding),
          // padding: EdgeInsets.only(left: 25),
          padding:
              const EdgeInsets.symmetric(horizontal: kPadding, vertical: 5),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            onTap: onTap,

            subtitle: Text(
              subtitle ?? "",
              style: style(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? BAppColor.kbgColor.withOpacity(0.45)
                    : BAppColor.kTextStyleColor.withOpacity(0.45),
              ),
            ),

            contentPadding: EdgeInsets.all(0),
            leading: Container(
              width: 50,
              height: 50,
              child: Icon(
                icon,
                color: isDarkMode
                    ? color ?? BAppColor.kbgColor
                    : color ?? BAppColor.kPrimaryColor,

                //size: 25,
              ),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? BAppColor.kDarkSecondColor
                    : BAppColor.kSecondColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            title: Text(
              title ?? "",
              style: style(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color:
                    isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
              ),
            ),

            //trailing: trialingWid
          )

          // Row(
          //   children: [
          //     Container(
          //       width: 50,
          //       height: 50,
          //       child: Icon(
          //         icon ?? IconlyBroken.call,
          //         color: isDarkMode
          //             ? color ?? BAppColor.kbgColor
          //             : color ?? BAppColor.kPrimaryColor,
          //         size: 25,
          //       ),
          //       decoration: BoxDecoration(
          //         color: isDarkMode
          //             ? BAppColor.kDarkSecondColor
          //             : BAppColor.kSecondColor.withOpacity(0.2),
          //         borderRadius: BorderRadius.circular(3),
          //       ),
          //     ),
          //     Gap(kPadding),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           title ?? "Call",
          //           style: style(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: isDarkMode
          //                 ? BAppColor.kbgColor
          //                 : BAppColor.kTextStyleColor,
          //           ),
          //         ),
          //         Text(
          //           subtitle ?? "You can call our help line",
          //           style: style(
          //             fontSize: 13,
          //             fontWeight: FontWeight.w500,
          //             color: isDarkMode
          //                 ? BAppColor.kbgColor.withOpacity(0.45)
          //                 : BAppColor.kTextStyleColor.withOpacity(0.45),
          //           ),
          //         )
          //       ],
          //     )
          //   ],
          // ),
          ),
    );
  }
}
