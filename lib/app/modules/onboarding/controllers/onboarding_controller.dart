import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/all_images_string.dart';
import '../../../../utils/constants/all_text_string.dart';
import '../models/onboarding_model.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  final box = GetStorage();

  List<OnBoardingModel> onboarding = [
    OnBoardingModel(
      title: BAllTexts.onBoardingTitle1,
      subTitle: BAllTexts.onBoardingSubTitle2,
      img: BAllImages.placeHolder,
    ),
    OnBoardingModel(
      title: BAllTexts.onBoardingTitle2,
      subTitle: BAllTexts.onBoardingSubTitle2,
      img: BAllImages.placeHolder,
    ),
    OnBoardingModel(
      title: BAllTexts.onBoardingTitle3,
      subTitle: BAllTexts.onBoardingSubTitle3,
      img: BAllImages.placeHolder,
    ),
    OnBoardingModel(
      title: BAllTexts.onBoardingTitle4,
      subTitle: BAllTexts.onBoardingSubTitle4,
      img: BAllImages.placeHolder,
    ),
  ];

  /// Anime
  animationDo(
    int index,
    int delay,
    Widget child,
  ) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  updateIndex(int index) {
    currentIndex = index;
    update();
  }

  onDotClicked(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    update();
  }

  skupButton() {
    pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );

    update();
  }
}
