import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewash/app/modules/favorate/controllers/favorate_controller.dart';
import 'package:ewash/app/modules/home/model/services_providers_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/api_or_keys_constants.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/reusable_constants.dart';
import 'popular_services_detail_page.dart';

class PopularServiceCardProvider extends StatelessWidget {
  const PopularServiceCardProvider({super.key, required this.serProvider});
  final ServiceProvidersModel serProvider;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    //bool isPortrait = BReusableConstants.isPortrait(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: PopularServicesDetail(serProvider: serProvider),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(kPadding - 8),
        // height: isPortrait ? 800 : 800,
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? BAppColor.kCardDarkbgColor //Theme.of(context).cardColor
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag:
                        "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg", //?? "assets/images/placeholder.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.28,

                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Get.isDarkMode
                            ? Color(0xff3f3f3f)
                            : Colors.grey[400]!,
                        highlightColor:
                            Get.isDarkMode ? Colors.white10 : Colors.grey[300]!,
                        child: Container(
                          width: double.infinity,
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
                Positioned(
                  right: 10,
                  top: 10,
                  child: GetBuilder<FavorateController>(
                    builder: (fav) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? BAppColor.kDarkSecondColor
                                : BAppColor.kSecondColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: LikeButton(
                              //padding: EdgeInsets.all(12),
                              onTap: (isLiked) async {
                                if (!isLiked) {
                                  fav.saveFavoriteServices(serProvider);
                                  return true;
                                } else {
                                  fav.removeFavoriteServices(serProvider);
                                  return false;
                                }
                              },
                              isLiked: fav.checkServicesInFavorite(serProvider),
                              //size: 25,
                              bubblesSize: 65,
                              likeBuilder: (bool isLiked) {
                                if (!isLiked) {
                                  return Icon(
                                    CupertinoIcons.heart,
                                    //size: 20,
                                    color: isDarkMode
                                        ? Colors.grey
                                        : BAppColor.kCheckOutActiveTextColor,
                                  );
                                }
                                return null;
                              },
                            ),
                          ),

                          // Icon(
                          //   IconlyBroken.heart,
                          //   size: 30,
                          //   color: BAppColor.khShadowColor,
                          // ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Gap(kPadding - 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeText(
                    "${serProvider.carType?.type ?? ""}",
                    style: style(
                      fontSize: 16,
                      color: isDarkMode
                          ? BAppColor.kbgColor
                          : BAppColor.kTextStyleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "\$${serProvider.price}",
                  style: style(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? BAppColor.kSecondColor
                        : BAppColor.kTextStyleColor,
                  ),
                ),
              ],
            ),
            Gap(kPadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                  decoration: BoxDecoration(
                    color: serProvider.status == "active"
                        ? isDarkMode
                            ? BAppColor.kDarkSecondColor
                            : BAppColor.kcheckInInActiveBgColor
                        : isDarkMode
                            ? BAppColor.kCardDarkbgColor
                            : BAppColor.kCheckOutInActiveBgColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    "${serProvider.status}",
                    style: TextStyle(
                      fontSize: 15,
                      color: serProvider.status == "active"
                          ? isDarkMode
                              ? BAppColor.kbgColor.withOpacity(0.65)
                              : BAppColor.kCheckInActiveTextColor
                          : isDarkMode
                              ? BAppColor.kbgColor.withOpacity(0.65)
                              : BAppColor.kCheckOutActiveTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gap(kPadding),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? BAppColor.kDarkSecondColor.withOpacity(0.75)
                        : BAppColor.kbgColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    "${serProvider.serviceType?.name ?? ""}",
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode
                          ? BAppColor.kbgColor.withOpacity(0.85)
                          : BAppColor.kTextStyleColor.withOpacity(0.75),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            //Gap(8),
            // Expanded(
            //   child: Container(
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       color: BAppColor.kSecondColor.withOpacity(0.45),
            //       //BAppColor.kPrimaryColor,
            //       borderRadius: BorderRadius.circular(4),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Book Now",
            //         style: style(
            //           fontSize: 17,
            //           color: BAppColor.kPrimaryColor,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
