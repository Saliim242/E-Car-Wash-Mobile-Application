import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:ewash/utils/constants/api_or_keys_constants.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/app_colors.dart';

class TransactionInfoCardWidget extends StatelessWidget {
  const TransactionInfoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return ClipPath(
      clipper: CouponClipper(
        direction: Directionality.of(context),
        curvePosition: MediaQuery.of(context).size.height * 0.07,
        curveRadius: 40,
        curveAxis: Axis.horizontal,
      ),
      child: ClipPath(
        clipper: ZigZagClipper(),
        child: Container(
          // width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.55,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDarkMode ? BAppColor.kCardDarkbgColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.receipt_1,
                    color: isDarkMode
                        ? BAppColor.kbgColor
                        : BAppColor.kPrimaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Transaction Receipe",
                    style: TextStyle(
                      fontSize: 15,
                      color: isDarkMode
                          ? BAppColor.kbgColor
                          : BAppColor.kTextStyleColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              MySeparator(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              LottieBuilder.asset(
                'assets/animations/success.json',
                fit: BoxFit.cover,
                animate: true,
                height: 150,

                ///width: 200,
              ),
              Gap(kPadding),
              Text(
                "Congratulations!",
                style: style(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? BAppColor.kbgColor
                      : BAppColor.kTextStyleColor,
                ),
              ),
              Gap(kPadding * 2),
              Text(
                "Your Car Washing Service Booked.",
                style: style(
                  fontSize: 14,
                  color: isDarkMode
                      ? BAppColor.kbgColor.withOpacity(0.65)
                      : BAppColor.kTextStyleColor.withOpacity(0.65),
                ),
              ),
              Gap(kPadding - 10),
              Text(
                "You can check your booking service.",
                style: style(
                  fontSize: 14,
                  color: isDarkMode
                      ? BAppColor.kbgColor.withOpacity(0.65)
                      : BAppColor.kTextStyleColor.withOpacity(0.65),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double x = 10;
    double y = size.height;
    double increment = size.width / 20;

    while (x < size.width) {
      x += increment;
      y = (y == size.height) ? size.height * .95 : size.height;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? BAppColor.kbgColor.withOpacity(0.65)
                      : Colors.black45,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
