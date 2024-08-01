import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewash/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/constants/api_or_keys_constants.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/reusable_constants.dart';
import '../home/components/bottom_shet_phone_number.dart';
import '../home/model/services_providers_model.dart';

class PopularServicesDetail extends StatelessWidget {
  const PopularServicesDetail({super.key, required this.serProvider});

  final ServiceProvidersModel serProvider;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    // bool isPortrait = BReusableConstants.isPortrait(context);
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 0,
      // ),
      body: GetBuilder<HomeController>(
        builder: (prop) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 310,
                // floating: true,
                backgroundColor: isDarkMode
                    ? Theme.of(context).cardColor
                    : BAppColor.kPrimaryColor,
                pinned: true,
                stretch: true,
                elevation: 0,
                leading: backArrow(),
                leadingWidth: 60,
                actions: [],
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                  ],
                  background: Hero(
                    //pro.thumbnail ??
                    tag:
                        "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                    child: CachedNetworkImage(
                      //https://www.build-review.com/wp-content/uploads/2020/07/luxury-real-estate.jpg
                      //pro.thumbnail ??
                      imageUrl:
                          "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",

                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.28,
                      placeholder: (context, url) => Shimmer.fromColors(
                        // baseColor: Theme.of(context).hoverColor.withOpacity(0.25),
                        // highlightColor: Theme.of(context).cardColor,
                        baseColor:
                            isDarkMode ? Color(0xff3f3f3f) : Colors.grey[400]!,
                        highlightColor:
                            isDarkMode ? Colors.white10 : Colors.grey[300]!,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.28,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).hoverColor.withOpacity(0.25),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => CachedNetworkImage(
                        imageUrl:
                            "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Gap(kPadding),
                      GetBuilder<HomeController>(
                        builder: (pr) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Price
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      //Modern House With Gorden
                                      "${serProvider.carType?.type ?? ""}",
                                      style: style(
                                        fontSize: 17,
                                        color: isDarkMode
                                            ? BAppColor.kbgColor
                                            : BAppColor.kTextStyleColor,
                                      ),
                                      // maxLines: 1,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "\$${serProvider.price} ", //5600
                                    style: style(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode
                                          ? BAppColor.kSecondColor
                                          : BAppColor.kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),

                              Gap(kPadding * 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: serProvider.status == "active"
                                          ? isDarkMode
                                              ? BAppColor.kCardDarkbgColor
                                              : BAppColor
                                                  .kcheckInInActiveBgColor
                                          : isDarkMode
                                              ? BAppColor.kCardDarkbgColor
                                              : BAppColor
                                                  .kCheckOutInActiveBgColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Iconsax.verify5,
                                          size: 18,
                                          color:
                                              BAppColor.kCheckInActiveTextColor,
                                          // BAppColor
                                          //     .agentActiveTextColor,
                                        ),
                                        Gap(kPadding - 10),
                                        Text(
                                          "${serProvider.status}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: serProvider.status ==
                                                    "active"
                                                ? isDarkMode
                                                    ? BAppColor.kbgColor
                                                        .withOpacity(0.65)
                                                    : BAppColor
                                                        .kCheckInActiveTextColor
                                                : isDarkMode
                                                    ? BAppColor.kbgColor
                                                        .withOpacity(0.65)
                                                    : BAppColor
                                                        .kCheckOutActiveTextColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(kPadding),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? BAppColor.kDarkSecondColor
                                              .withOpacity(0.75)
                                          : BAppColor.kbgColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Text(
                                      "${serProvider.serviceType?.name ?? ""}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDarkMode
                                            ? BAppColor.kbgColor
                                                .withOpacity(0.85)
                                            : BAppColor.kTextStyleColor
                                                .withOpacity(0.75),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),

                              Gap(kPadding + 6),
                              // Description Section
                              Text(
                                "Description",
                                style: style(
                                  fontSize: 16,
                                  color: isDarkMode
                                      ? BAppColor.kbgColor
                                      : BAppColor.kTextStyleColor,
                                ),
                              ),

                              // // Review Title Section
                              // ReusableTextTitles(
                              //   title:
                              //       "Reviews and Ratings (${pro.initialRating})",
                              //   viewAll: "Add a review",
                              //   onPressed: () {
                              //     Get.to(
                              //       () => AddNewReviewScreen(
                              //         pro: pro,
                              //       ),
                              //       transition: Transition.downToUp,
                              //     );
                              //   },
                              // ),

                              // UserReveiw Card
                              // Column(
                              //   children: [
                              //     LayoutBuilder(
                              //       builder: (context, constraints) {
                              //         return pro.reviews != null &&
                              //                 pro.reviews!.isNotEmpty
                              //             ? SizedBox(
                              //                 height:
                              //                     constraints.maxWidth * 0.3,
                              //                 child: ListView.builder(
                              //                   itemCount: pro.reviews!.length,
                              //                   scrollDirection:
                              //                       Axis.horizontal,
                              //                   itemBuilder:
                              //                       (context, int index) {
                              //                     return Container(
                              //                       margin: EdgeInsets.only(
                              //                           right: 10),
                              //                       child: UserReviewCard(
                              //                         initialRating:
                              //                             double.parse(pro
                              //                                     .reviews?[
                              //                                         index]
                              //                                     .rating
                              //                                     .toString() ??
                              //                                 "0"),
                              //                         userPropertReviewDes: pro
                              //                                 .reviews?[index]
                              //                                 .comment
                              //                                 .toString() ??
                              //                             "",
                              //                         userReveiw: pro
                              //                                 .reviews?[index]
                              //                                 .reviewerName
                              //                                 .toString() ??
                              //                             "",
                              //                       ),
                              //                     );
                              //                   },
                              //                 ),
                              //               )
                              //             : Center(
                              //                 child:
                              //                     Text("No reviews available"),
                              //               );
                              //       },
                              //     ),
                              //     TextButton(
                              //       style: TextButton.styleFrom(
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 0, vertical: 0),
                              //         elevation: 0,
                              //       ),
                              //       onPressed: () {},
                              //       child: Text(
                              //         RAllText.viewMore,
                              //         style: style(
                              //           fontSize: 14,
                              //           color: Get.isDarkMode
                              //               ? BAppColor.kSecondColor
                              //               : BAppColor.kSecondColor,
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),

                              Gap(kPadding),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            enableDrag: true,
            showDragHandle: true,
            backgroundColor:
                Get.isDarkMode ? Color(0xff181D2D) : BAppColor.kbgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return PhoneNumberBottomSheet(
                model: serProvider,
              );
            },
          );
        },
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: BAppColor.kPrimaryColor,
            //BAppColor.kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          ),
          child: Center(
            child: Text(
              "Make Booking Now",
              style: style(
                fontSize: 17,
                color: BAppColor.kbgColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
