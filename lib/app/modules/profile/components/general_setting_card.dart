import 'package:ewash/utils/constants/api_or_keys_constants.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class GeneralInSettingCard extends StatelessWidget {
  const GeneralInSettingCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
    this.subtitle,
    this.color,
    this.bgcolor,
  });

  final String title;
  final void Function()? onTap;
  final IconData icon;
  final Widget? trailing;
  final String? subtitle;
  final Color? color;
  final Color? bgcolor;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);

    return ListTile(
      onTap: onTap,
      trailing: trailing,
      subtitle: Text(
        subtitle ?? "",
        style: style(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDarkMode
              ? color ?? BAppColor.kbgColor.withOpacity(0.45)
              : color ?? BAppColor.kTextStyleColor.withOpacity(0.45),
        ),
      ),

      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 40,
        height: 40,
        child: Icon(
          icon,
          color: isDarkMode
              ? color ?? BAppColor.kbgColor
              : color ?? BAppColor.kPrimaryColor,

          //size: 25,
        ),
        decoration: BoxDecoration(
          color: isDarkMode
              ? bgcolor ?? BAppColor.kDarkSecondColor
              : bgcolor ?? BAppColor.kSecondColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      title: Text(
        title,
        style: style(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isDarkMode
              ? color ?? BAppColor.kbgColor
              : color ?? BAppColor.kTextStyleColor,
        ),
      ),

      //trailing: trialingWid
    );
  }
}
