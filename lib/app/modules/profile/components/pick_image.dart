import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';

class PickImage extends StatelessWidget {
  final void Function()? onTap;
  final IconData pickIconImage;
  final String pickImageTitle;

  const PickImage({
    super.key,
    this.onTap,
    required this.pickIconImage,
    required this.pickImageTitle,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDarkMode
                ? BAppColor.kCardDarkbgColor
                : BAppColor.kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: BAppColor.kCardDarkbgColor.withOpacity(0.2),
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  pickIconImage,
                  color:
                      isDarkMode ? BAppColor.kbgColor : BAppColor.kSecondColor,
                  size: 45,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          textAlign: TextAlign.center,
          pickImageTitle,
          style: style(
            fontSize: 17,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),
        ),
      ],
    );
  }
}
