import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../components/onboarding_btn.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(),
      body: GetBuilder<OnboardingController>(
        builder: (onb) {
          return SafeArea(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      controller: onb.pageController,
                      itemCount: onb.onboarding.length,
                      onPageChanged: (index) => onb.updateIndex(index),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: Column(
                            children: [
                              /// IMG
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 40, 15, 10),
                                width: size.width,
                                decoration: BoxDecoration(),
                                height: size.height / 2.5,
                                child: onb.animationDo(
                                  index,
                                  100,
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      onb.onboarding[index].img,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              /// TITLE TEXT
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 15),
                                child: onb.animationDo(
                                  index,
                                  300,
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kPadding),
                                    child: Text(
                                      onb.onboarding[index].title,
                                      textAlign: TextAlign.center,
                                      style: style(
                                        fontSize: kPadding + 2,
                                        color: BAppColor.kTextStyleColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              /// SUBTITLE TEXT
                              onb.animationDo(
                                index,
                                500,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kPadding),
                                  child: Text(
                                    onb.onboarding[index].subTitle,
                                    textAlign: TextAlign.center,
                                    style: style(
                                      fontSize: 14,
                                      color: BAppColor.kTextStyleColor
                                          .withOpacity(0.65),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  /// ---------------------------
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// PAGE INDICATOR
                        SmoothPageIndicator(
                          controller: onb.pageController,
                          count: onb.onboarding.length,
                          effect: ExpandingDotsEffect(
                            spacing: 6.0,
                            radius: 10.0,
                            dotWidth: 10.0,
                            dotHeight: 5.0,
                            expansionFactor: 3.8,
                            dotColor: Colors.grey,
                            activeDotColor: BAppColor.kPrimaryColor,
                          ),
                          onDotClicked: (index) => onb.onDotClicked(index),
                        ),
                        onb.currentIndex == 3

                            /// GET STARTED BTN
                            ? GetStartBtn(size: size)

                            /// SKIP BTN
                            : SkipBtn(
                                size: size,
                                onTap: () => onb.skupButton(),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
