import 'package:ewash/utils/constants/api_or_keys_constants.dart';
import 'package:ewash/utils/constants/reusable_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../user/controllers/user_controller.dart';

class CustomEditTextFeilds extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final IconData? passIcon;
  final void Function()? onTap;
  final bool showPassowrd;
  final TextEditingController controller;
  final bool isEmail;
  final bool ispassword;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool readOnly;

  const CustomEditTextFeilds({
    super.key,
    required this.hintText,
    this.iconData,
    this.passIcon,
    this.onTap,
    required this.showPassowrd,
    required this.controller,
    this.isEmail = false,
    this.ispassword = false,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GetBuilder<UserController>(builder: (e) {
      return Container(
        child: TextFormField(
          readOnly: readOnly,
          maxLines: maxLines,
          scrollPadding: const EdgeInsets.all(0),
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          obscuringCharacter: '*',
          validator: (value) {
            if (value!.isEmpty || value == '') {
              return '';
            } else if (isEmail ? !e.isEmailValid(value) : false) {
              return 'Oops! Your email format seems off. Please enter a valid email address.';
            } else if (ispassword ? value.length < 8 : false) {
              return "Whoops! Password needs at least 8 characters. Add a bit more length.";
              //ispassword ? !e.isPasswordValid(value) : false
            }
            return null;
          },
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(18),
            border: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.grey.shade200 : Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueGrey, width: 1),
            ),
            focusedBorder: readOnly
                ? OutlineInputBorder().copyWith(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.blueGrey, width: 1),
                  )
                : OutlineInputBorder().copyWith(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: BAppColor.kPrimaryColor,
                      width: 1,
                    ),
                  ),
            errorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: BAppColor.kCheckOutActiveTextColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: BAppColor.kSecondColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            hintText: hintText,
            hintStyle: style(
              fontSize: 14,
              color: isDarkMode
                  ? Colors.grey.shade300.withOpacity(0.6)
                  : BAppColor.kTextStyleColor.withOpacity(0.6),
            ),
            prefixIcon: Icon(
              iconData,
              size: 24,
              color:
                  isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
            ),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(
                passIcon,
                size: 24,
                color:
                    isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
              ),
            ),
          ),
          style: style(
            fontSize: 15,
            color: isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),

          // style(
          //   fontSize: 15,
          //   color: BAppColor.kTextStyleColor,
          // ),
          obscureText: showPassowrd,
        ),
      );
    });
  }
}
