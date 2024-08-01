import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/reusable_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.btnText,
    this.onTap,
  });

  final String btnText;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color:
              isDarkMode ? BAppColor.kCardDarkbgColor : BAppColor.kPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          btnText,
          style: TextStyle(
            color: BAppColor.kbgColor,
            fontSize: 17,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
