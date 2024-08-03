import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/reusable_constants.dart';
import '../../components/custom_error.dart';
import '../../components/popular_services_provider.dart';
import '../controllers/favorate_controller.dart';

class FavorateView extends GetView<FavorateController> {
  const FavorateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    //bool isPortrait = BReusableConstants.isPortrait(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Favorite Services",
          style: style(
            fontSize: 16,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(kPadding * 3),
                      GetBuilder<FavorateController>(
                        builder: (favo) {
                          if (favo.favoriteServices.isEmpty) {
                            return CustomEmplyScreen(
                              img: 'assets/animations/empty.json',
                              //Oops! Your Favorites List is Feeling a Bit Empty! 🌟
                              content:
                                  'Start adding your dream Service Provider to create your own personalized collection and let the magic begin!',
                            );

                            // CustomEmplyScreen(
                            //   img: 'assets/animations/empty.json',
                            //   //Oops! Your Favorites List is Feeling a Bit Empty! 🌟
                            //   content:
                            //       'Start adding your dream house to create your own personalized collection and let the magic begin!',
                            // );
                          }

                          return SizedBox(
                            child: ListView.builder(
                              itemCount: favo.favoriteServices.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, int index) {
                                return PopularServiceProvider(
                                  serProvider: favo.favoriteServices[index],
                                );

                                //   FeaturedPropertyCard(
                                // //   feat: favo.favoriteProperty[index],
                                // // );
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
