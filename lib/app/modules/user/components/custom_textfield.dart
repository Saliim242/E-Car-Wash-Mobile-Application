import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_colors.dart';
import '../controllers/user_controller.dart';

class CustomTextFeilds extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final IconData? iconData;
  final IconData? passIcon;
  final void Function()? onTap;
  final bool showPassowrd;
  final TextEditingController controller;
  final bool isEmail;
  final bool ispassword;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final void Function()? onTapTextFeild;

  const CustomTextFeilds({
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
    this.readOnly = false,
    this.onTapTextFeild,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (e) {
      return Container(
        child: TextFormField(
          onTap: onTapTextFeild,
          scrollPadding: EdgeInsets.all(0),
          keyboardType: keyboardType,
          readOnly: readOnly ?? false,
          textInputAction: TextInputAction.next,
          obscuringCharacter: '*',
          validator: (value) {
            if (value!.isEmpty || value == '') {
              return errorText ?? '';
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
            contentPadding: EdgeInsets.all(18),

            border: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Get.isDarkMode ? Colors.grey.shade200 : Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blueGrey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: BAppColor.kPrimaryColor,
                width: 1,
              ),
            ),
            // errorBorder: const OutlineInputBorder().copyWith(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(
            //     color: kJtechSecondColor,
            //     width: 1,
            //   ),
            // ),
            focusedErrorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: BAppColor.kSecondColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            hintText: hintText,

            hintStyle: TextStyle(
              fontSize: 14,
              color: Get.isDarkMode
                  ? Colors.grey.shade300.withOpacity(0.6)
                  : BAppColor.kTextStyleColor.withOpacity(0.6),
            ),
            prefixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(
                iconData,
                size: 24,
                color: Get.isDarkMode
                    ? BAppColor.kbgColor.withOpacity(0.6)
                    : BAppColor.kTextStyleColor,
              ),
            ),

            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(
                passIcon,
                size: 24,
                color: Get.isDarkMode
                    ? BAppColor.kbgColor.withOpacity(0.6)
                    : BAppColor.kTextStyleColor,
              ),
            ),
          ),
          style: TextStyle(
            fontSize: 15,
            color:
                Get.isDarkMode ? BAppColor.kbgColor : BAppColor.kTextStyleColor,
          ),
          obscureText: showPassowrd,
        ),
      );
    });
  }
}
