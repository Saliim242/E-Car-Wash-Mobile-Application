import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:ewash/utils/constants/api_or_keys_constants.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/app_colors.dart';

class ServiceLoadingShimmerLoading extends StatelessWidget {
  const ServiceLoadingShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return Container(
      padding: EdgeInsets.all(kPadding - 8),
      // width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color:  //Get.isDarkMode ? Theme.of(context).cardColor : Color(0xfff2f2f2),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Shimmer.fromColors(
        baseColor: isDarkMode ? BAppColor.kDarkSecondColor : Colors.grey[300]!,
        highlightColor: isDarkMode
            ? BAppColor.kSecondColor.withOpacity(0.45)
            : Colors.grey[100]!,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.22,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            Gap(kPadding - 4),
            // Property Name and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Gap(kPadding * 2),
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              ],
            ),
            Gap(kPadding - 10),
            // Propert Location
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: kPadding),
                    // width: MediaQuery.of(context).size.width,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            Gap(kPadding),

            // Propert BedRooms , Bath , etc

            Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
