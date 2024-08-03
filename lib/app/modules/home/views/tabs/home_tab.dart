import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:ewash/app/modules/user/controllers/user_controller.dart';
import 'package:ewash/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../../utils/constants/reusable_constants.dart';
import '../../../components/popular_service_card_provider.dart';
import '../../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    bool isPortrait = BReusableConstants.isPortrait(context);
    final customer = Get.find<UserController>();
    return GetBuilder<HomeController>(
      builder: (home) {
        return RefreshIndicator(
          onRefresh: () async {
            home.displayServiceProviders();
            home.displayServicesTypes();
          },
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(kPadding),
                          Container(
                            padding: EdgeInsets.all(25),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? BAppColor.kDarkSecondColor
                                  : BAppColor.kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Welcome Back !  ",
                                    style: style(
                                      fontSize: 16,
                                      color: BAppColor.kbgColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${customer.user.name}",
                                        style: style(
                                          fontSize: 18,
                                          color: BAppColor.kbgColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Gap(kPadding - 4),
                                Text(
                                  "Enjoy our top-notch car wash services at E-wash. Your car will thank you!",
                                  style: style(
                                    fontSize: 18,
                                    color: BAppColor.kbgColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(kPadding * 2),
                          Text(
                            "Service which we over",
                            style: style(
                              fontSize: 18,
                              color: isDarkMode
                                  ? BAppColor.kbgColor
                                  : BAppColor.kTextStyleColor,
                            ),
                          ),
                          Gap(kPadding),
                          GetBuilder<HomeController>(
                            builder: (ser) {
                              if (ser.isServiceTypesLoading) {
                                return Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: BAppColor.kCheckInActiveTextColor,
                                    size: 40,
                                  ),
                                );
                              } else if (ser.serviceTypes.isEmpty) {
                                return Center(
                                  child: Text("No Service Found"),
                                );
                              }

                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.055,
                                child: ListView.builder(
                                  itemCount: ser.serviceTypes.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Chip(
                                        backgroundColor: isDarkMode
                                            ? BAppColor.kDarkSecondColor
                                            : Colors.grey.shade300,
                                        side: BorderSide.none,
                                        avatar: Icon(LineIcons.jira),
                                        label: Text(
                                          ser.serviceTypes[index].name ?? "",
                                          style: style(
                                            fontSize: 15,
                                            color: isDarkMode
                                                ? BAppColor.kbgColor
                                                : BAppColor.kTextStyleColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          Gap(kPadding * 2),
                          Text(
                            "Popular Service",
                            style: style(
                              fontSize: 18,
                              color: isDarkMode
                                  ? BAppColor.kbgColor
                                  : BAppColor.kTextStyleColor,
                            ),
                          ),
                          Gap(kPadding * 2),
                          // PopularServiceProvider(),
                          // Gap(kPadding * 2),
                          GetBuilder<HomeController>(
                            builder: (pro) {
                              if (pro.isServiceProviderLoading) {
                                return Center(
                                    child: CircularProgressIndicator.adaptive()
                                    //PropertyShimmerLoading(),
                                    );
                              } else if (pro.serProviders.isEmpty) {
                                return Center(
                                  child: Text("No Services Provider Found"),
                                );
                              }

                              return SizedBox(
                                height: isPortrait
                                    ? MediaQuery.of(context).size.height * 0.45
                                    : MediaQuery.of(context).size.height * 0.65,
                                child: Swiper(
                                  loop: false,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PopularServiceCardProvider(
                                      serProvider: pro.serProviders[index],
                                    );
                                  },
                                  itemCount: pro.serProviders.length,

                                  // itemWidth: 300.0,
                                  //itemHeight: 200,
                                  layout: SwiperLayout.DEFAULT,
                                  onIndexChanged: (index) {
                                    log("Indexes are $index");
                                  },
                                  onTap: (index) {},

                                  // pagination: SwiperPagination(
                                  //   margin: EdgeInsets.all(5.0),
                                  // ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
