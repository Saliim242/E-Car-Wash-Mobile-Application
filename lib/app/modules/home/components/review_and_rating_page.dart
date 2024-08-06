import 'package:ewash/app/modules/home/controllers/home_controller.dart';
import 'package:ewash/app/modules/home/model/services_providers_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';

class ReviewAndRatingPage extends StatefulWidget {
  const ReviewAndRatingPage({super.key, required this.service});

  final ServiceProvidersModel service;

  @override
  State<ReviewAndRatingPage> createState() => _ReviewAndRatingPageState();
}

class _ReviewAndRatingPageState extends State<ReviewAndRatingPage> {
  double rateValue = 0.0;
  late TextEditingController reviewText;

  @override
  void initState() {
    super.initState();
    reviewText = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    reviewText.dispose();
  }

  void onRatingUpdate(double newValue) {
    setState(() {
      rateValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GetBuilder<HomeController>(builder: (ho) {
      return ModalProgressHUD(
        inAsyncCall: ho.isReviewAndRatingLoading,
        blur: 0.85,
        progressIndicator: Center(
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: BAppColor.kPrimaryColor, //Color(0XFF8f8f8f),
              borderRadius: BorderRadius.circular(10),
            ),
            child: LoadingAnimationWidget.dotsTriangle(
              size: 50,
              color: BAppColor.kbgColor,
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
            // automaticallyImplyLeading: false,
            leading: backArrow(),
            elevation: 0,
            title: Text(
              "leave Review",
              style: style(
                fontSize: 16,
                color:
                    isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
              ),
            ),
            centerTitle: true,
            actions: [],
          ),
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GetBuilder<HomeController>(builder: (home) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(kPadding * 3),

                            Text(
                              "Rate The Service:",
                              style: style(
                                fontSize: 18,
                                color: isDarkMode
                                    ? BAppColor.kbgColor
                                    : BAppColor.kTextStyleColor,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            Gap(kPadding),

                            Align(
                              alignment: Alignment.center,
                              child: RatingBar.builder(
                                wrapAlignment: WrapAlignment.center,
                                // itemSize: 35.0,
                                initialRating: rateValue,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,

                                maxRating: 5,
                                updateOnDrag: true,
                                // unratedColor:
                                //     BAppColor.kTextStyleColor.withOpacity(0.75),
                                itemBuilder: (context, _) => Icon(
                                  Iconsax.star1,
                                  color: BAppColor.kPrimaryColor,
                                ),
                                onRatingUpdate: (rating) =>
                                    onRatingUpdate(rating),
                              ),
                            ),
                            Gap(kPadding),
                            Divider(
                              color: isDarkMode
                                  ? BAppColor.kbgColor.withOpacity(0.25)
                                  : BAppColor.kTextStyleColor.withOpacity(0.25),
                              thickness: 0.55,
                              endIndent: 25,
                              indent: 25,
                            ),
                            Gap(kPadding),
                            // ReusableTextTitles(
                            //   title: RAllText.addRatingDetail,
                            //   viewAll: "",
                            // ),
                            Gap(kPadding - 7),
                            ReviewDetails(controller: reviewText),
                            Gap(kPadding),
                            Row(
                              children: [
                                // Expanded(
                                //   child: CancelButtom(
                                //     text: "Cancel",
                                //     onPressed: () {},
                                //   ),
                                // ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: home.isReviewAndRatingLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : SubmitButton(
                                          text: "Submit Review",
                                          onPressed: () {
                                            print(
                                                " Review ${rateValue} and Text ${reviewText.text} And The Service ID : ${widget.service.sId}");

                                            home.createReviewAndRating(
                                              comment: reviewText.text,
                                              rating: rateValue.toString(),
                                              service: widget.service,
                                            );

                                            setState(() {
                                              rateValue = 0.0;
                                              reviewText.clear();
                                            });
                                          },
                                        ),
                                )
                              ],
                            ),
                            Gap(kPadding),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 150,
      //margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? BAppColor.kCardDarkbgColor
            : Colors.white, //Color(0xfff2f2f2)
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: style(
          fontSize: 16,
          color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
        ),
        controller: controller,
        maxLines: null,
        // maxLength: 500,
        expands: true,
        onTap: () {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: "Add Review Detail",
          hintStyle: style(
            fontSize: 13,
            color: isDarkMode
                ? BAppColor.kbgColor.withOpacity(0.5)
                : BAppColor.kTextStyleColor.withOpacity(0.5),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// Submit Buttom

class SubmitButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  SubmitButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.065,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDarkMode ? BAppColor.kPrimaryColor : BAppColor.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: style(
            fontSize: 16,
            color: BAppColor.kbgColor,
          ),
        ),
      ),
    );
  }
}

//Cancle Buttom
class CancelButtom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CancelButtom({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.065,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: BAppColor.kPrimaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: style(
            fontSize: 16,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
