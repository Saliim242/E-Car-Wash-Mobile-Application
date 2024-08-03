import 'package:ewash/utils/constants/api_or_keys_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../utils/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.btnText,
    this.onTap,
    this.icon,
  });

  final String btnText;
  final IconData? icon;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          //  isDarkMode ? BAppColor.kCardDarkbgColor :
          color: BAppColor.kPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: BAppColor.kbgColor,
            ),
            Gap(kPadding - 10),
            Text(
              btnText,
              style: TextStyle(
                color: BAppColor.kbgColor,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
