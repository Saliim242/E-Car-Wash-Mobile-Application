import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/api_or_keys_constants.dart';
import '../../../utils/constants/app_colors.dart';
import '../favorate/controllers/favorate_controller.dart';
import '../home/model/services_providers_model.dart';
import 'popular_services_detail_page.dart';

class NewPopularServiceCard extends StatelessWidget {
  const NewPopularServiceCard({super.key, required this.serProvider});
  final ServiceProvidersModel serProvider;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    bool isPortrait = BReusableConstants.isPortrait(context);

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
        alignment: Alignment.center,
        padding: EdgeInsets.all(kPadding - 8),
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        // height: isPortrait
        //     ? MediaQuery.of(context).size.height * 0.45
        //     : MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image of The Properties
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${serProvider.image ?? "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg"}", //?? "assets/images/placeholder.jpg",
                      fit: BoxFit.cover,
                      width: isPortrait
                          ? MediaQuery.of(context).size.height * 0.13
                          : MediaQuery.of(context).size.height * 0.3,
                      height: isPortrait
                          ? MediaQuery.of(context).size.height * 0.15
                          : MediaQuery.of(context).size.height * 0.3,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor:
                            isDarkMode ? Color(0xff3f3f3f) : Colors.grey[400]!,
                        highlightColor:
                            isDarkMode ? Colors.white10 : Colors.grey[300]!,
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.11,
                          height: MediaQuery.of(context).size.height * 0.11,
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
                  left: 4,
                  top: 8,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
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
                )
              ],
            ),
            Gap(kPadding - 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  AutoSizeText(
                    "${serProvider.carType?.type ?? ""}",
                    style: style(
                      fontSize: 14,
                      color: isDarkMode
                          ? BAppColor.kbgColor
                          : BAppColor.kTextStyleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AutoSizeText(
                    serProvider.description ?? "",
                    style: style(
                      fontSize: 14,
                      color: isDarkMode
                          ? BAppColor.kbgColor
                          : BAppColor.kTextStyleColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Location
                  Gap(kPadding - 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                      //   decoration: BoxDecoration(
                      //     color: serProvider.status == "active"
                      //         ? isDarkMode
                      //             ? BAppColor.kDarkSecondColor
                      //             : BAppColor.kcheckInInActiveBgColor
                      //         : isDarkMode
                      //             ? BAppColor.kCardDarkbgColor
                      //             : BAppColor.kCheckOutInActiveBgColor,
                      //     borderRadius: BorderRadius.circular(2),
                      //   ),
                      //   child: Text(
                      //     "${serProvider.status}",
                      //     style: TextStyle(
                      //       fontSize: 15,
                      //       color: serProvider.status == "active"
                      //           ? isDarkMode
                      //               ? BAppColor.kbgColor.withOpacity(0.65)
                      //               : BAppColor.kCheckInActiveTextColor
                      //           : isDarkMode
                      //               ? BAppColor.kbgColor.withOpacity(0.65)
                      //               : BAppColor.kCheckOutActiveTextColor,
                      //     ),
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                      //Gap(kPadding),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 2),
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
                  Gap(kPadding - 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "\$${serProvider.price}",
                          style: style(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? BAppColor.kSecondColor
                                : BAppColor.kTextStyleColor,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            // color: isDarkMode
                            //     ? BAppColor.kDarkSecondColor
                            //     : BAppColor.kSecondColor,
                            // shape: BoxShape.rectangle,
                            ),
                        child: GetBuilder<FavorateController>(
                          builder: (fav) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,

                                decoration: BoxDecoration(
                                    // color: isDarkMode
                                    //     ? BAppColor.kDarkSecondColor
                                    //     : BAppColor.kSecondColor,
                                    // shape: BoxShape.circle,
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
                                    isLiked: fav
                                        .checkServicesInFavorite(serProvider),
                                    //size: 25,
                                    bubblesSize: 65,
                                    likeBuilder: (bool isLiked) {
                                      if (!isLiked) {
                                        return Icon(
                                          IconlyBroken.heart,
                                          //size: 20,
                                          color: isDarkMode
                                              ? Colors.grey
                                              : BAppColor.kPrimaryColor,
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

                        // Icon(
                        //   IconlyBroken.heart,
                        //   color: BAppColor.kPrimaryColor,
                        // ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
