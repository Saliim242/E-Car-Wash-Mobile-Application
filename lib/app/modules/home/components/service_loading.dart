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
    bool isPortrait = BReusableConstants.isPortrait(context);
    return Container(
      // decoration: BoxDecoration(
      //   color: isDarkMode ? Theme.of(context).cardColor : Color(0xfff2f2f2),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      margin: EdgeInsets.only(bottom: 10),
      //padding: EdgeInsets.all(kPadding - 8),
      child: Shimmer.fromColors(
        baseColor: isDarkMode ? BAppColor.kDarkSecondColor : Colors.grey[300]!,
        highlightColor: isDarkMode
            ? BAppColor.kSecondColor.withOpacity(0.45)
            : Colors.grey[100]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image of The Properties
            Container(
              width: isPortrait
                  ? MediaQuery.of(context).size.height * 0.13
                  : MediaQuery.of(context).size.height * 0.3,
              height: isPortrait
                  ? MediaQuery.of(context).size.height * 0.15
                  : MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Gap(kPadding - 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Location
                  Gap(kPadding - 11),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Gap(kPadding - 10),
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(kPadding - 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Gap(kPadding - 10),
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Gap(kPadding - 10),
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(kPadding - 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )
                    ],
                  ),
                  Gap(kPadding - 8),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Gap(kPadding),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
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
