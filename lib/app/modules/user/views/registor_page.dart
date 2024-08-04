import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../utils/constants/all_text_string.dart';
import '../../../../utils/constants/app_colors.dart';
import '../components/custom_buttom.dart';
import '../components/custom_textfield.dart';
import '../controllers/user_controller.dart';

class createAccount extends StatefulWidget {
  const createAccount({super.key});

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  // Customer
  final TextEditingController cusnameController = TextEditingController();
  final TextEditingController cusEmailController = TextEditingController();
  final TextEditingController cusPhoneController = TextEditingController();
  final TextEditingController cusPassController = TextEditingController();
  final TextEditingController cusconfirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cusEmailController.dispose();
    cusPassController.dispose();
    cusnameController.dispose();
    cusPhoneController.dispose();
    cusconfirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GetBuilder<UserController>(
      builder: (login) {
        return ModalProgressHUD(
          inAsyncCall: login.isCustomerLoading,
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
              key: login.customerInformKey,
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075),

                          // Image.asset("assets/logo/lightLogo-01.png"),
                          // SizedBox(
                          //     height: MediaQuery.of(context).size.height * 0.03),
                          Text(
                            BAllTexts.createNewAccount,
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkMode
                                  ? BAppColor.kbgColor
                                  : BAppColor.kTextStyleColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            BAllTexts.signUpDiscover,
                            style: TextStyle(
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
                            hintText: BAllTexts.fullName,
                            iconData: IconlyBroken.profile,
                            showPassowrd: false,
                            controller: cusnameController,
                            isEmail: false,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025),
                          CustomTextFeilds(
                            hintText: BAllTexts.email,
                            iconData: IconlyBroken.message,
                            showPassowrd: false,
                            controller: cusEmailController,
                            isEmail: true,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025),
                          CustomTextFeilds(
                            hintText: BAllTexts.phoneNumber,
                            iconData: IconlyBroken.call,
                            showPassowrd: false,
                            controller: cusPhoneController,
                            isEmail: false,
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025),
                          CustomTextFeilds(
                            controller: cusPassController,
                            hintText: BAllTexts.password,
                            iconData: IconlyBroken.password,
                            passIcon: login.isCreatepassword
                                ? IconlyBroken.hide
                                : IconlyBroken.show,
                            onTap: () {
                              login.createshowAndHidePassword();
                            },
                            showPassowrd: login.isCreatepassword,
                            ispassword: true,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025),

                          CustomTextFeilds(
                            controller: cusconfirmPasswordController,
                            hintText: BAllTexts.confirmPassowrd,
                            iconData: IconlyBroken.password,
                            passIcon: login.isCreatepassword
                                ? IconlyBroken.hide
                                : IconlyBroken.show,
                            onTap: () {
                              login.createshowAndHidePassword();
                            },
                            showPassowrd: login.isCreatepassword,
                            ispassword: true,
                            keyboardType: TextInputType.number,
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025),
                          CustomButton(
                            btnText: BAllTexts.createAccount,
                            onTap: () => login.registoCustomer(
                              name: cusnameController.text,
                              email: cusEmailController.text,
                              phone: cusPhoneController.text,
                              password: cusPassController.text,
                              confPass: cusconfirmPasswordController.text,
                            ),
                          ),
                          Gap(15),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  BAllTexts.alreadyHaveAccount,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isDarkMode
                                        ? BAppColor.kbgColor
                                        : BAppColor.kTextStyleColor,
                                  ),
                                ),
                                Gap(2),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(0)),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    BAllTexts.btnSignIn,
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
