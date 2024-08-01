import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../utils/constants/all_text_string.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/reusable_constants.dart';
import '../../../../utils/theme/theme_services.dart';
import '../components/custom_buttom.dart';
import '../components/custom_textfield.dart';
import '../controllers/user_controller.dart';
import 'registor_page.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = BReusableConstants.isDarkMode(context);
    return GetBuilder<UserController>(
      builder: (user) {
        return ModalProgressHUD(
          inAsyncCall: user.isLoading,
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
            body: Form(
              key: user.signInformKey,
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075),
                          IconButton(
                            onPressed: () {
                              ServicesThemes().changeThemeDynamically();
                            },
                            icon: Icon(Icons.dark_mode_rounded),
                          ),
                          // Image.asset("assets/logo/lightLogo-01.png"),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Text(
                            BAllTexts.welcome,
                            style: style(
                              fontSize: 18,
                              color: isDarkMode
                                  ? BAppColor.kbgColor
                                  : BAppColor.kTextStyleColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Text(
                            BAllTexts.discover,
                            style: style(
                              fontSize: 14.5,
                              color: isDarkMode
                                  ? BAppColor.kbgColor
                                  : BAppColor.kTextStyleColor,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          CustomTextFeilds(
                            hintText: BAllTexts.eMailHint,
                            iconData: IconlyBroken.message,
                            showPassowrd: false,
                            controller: user.emailController,
                            isEmail: true,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025),
                          CustomTextFeilds(
                            controller: user.passwordController,
                            hintText: BAllTexts.passwordHint,
                            iconData: IconlyBroken.password,
                            passIcon: user.ispassword
                                ? IconlyBroken.hide
                                : IconlyBroken.show,
                            onTap: () {
                              user.showAndHideSignInPassword();
                            },
                            showPassowrd: user.ispassword,
                            ispassword: true,
                            keyboardType: TextInputType.number,
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          CustomButton(
                            btnText: BAllTexts.btnSignIn,
                            onTap: () => user.login(context),
                          ),
                          Gap(15),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  BAllTexts.dontHaveAnacount,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isDarkMode
                                        ? BAppColor.kbgColor
                                        : BAppColor.kTextStyleColor,
                                  ),
                                ),
                                Gap(6),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(0)),
                                  onPressed: () {
                                    Get.to(
                                      () => createAccount(),
                                      transition: Transition.rightToLeft,
                                    );
                                  },
                                  child: Text(
                                    BAllTexts.createAccount,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: BAppColor.kSecondColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
