import 'dart:developer';
import 'dart:io';
import 'package:ewash/app/modules/user/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../model/user_model.dart';
import '../providers/user_provider.dart';

class UserController extends GetxController {
  UserController() {
    getUser();
    getCustomer();
  }

  final box = GetStorage();
  UserModel user = UserModel();
  CustomerModel customer = CustomerModel();
  bool isLoading = false;
  bool isCustomerLoading = false;
  bool isUserprofileLoading = false;
  bool isSocket = false;
  final signInformKey = GlobalKey<FormState>();
  final customerInformKey = GlobalKey<FormState>();
  bool ispassword = true;
  bool isCreatepassword = true;
  bool get isSignIn => box.hasData(kUserInfo) && box.read(kUserToken) != null;
  // SignIn Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Customer
  final TextEditingController cusnameController = TextEditingController();
  final TextEditingController cusEmailController = TextEditingController();
  final TextEditingController cusPhoneController = TextEditingController();
  final TextEditingController cusPassController = TextEditingController();
  final TextEditingController cusconfirmPasswordController =
      TextEditingController();

  // Show and Hide Password
  void showAndHideSignInPassword() {
    ispassword = !ispassword;
    update();
  }

  // Creating Accoung Show and Hide pass
  void createshowAndHidePassword() {
    isCreatepassword = !isCreatepassword;
  }

  // Email Validation
  bool isEmailValid(String email) {
    String emailRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  // Password Validation Function
  bool isPasswordValid(String password) {
    // Define your password strength criteria here
    // For example, at least 8 characters, one uppercase letter, one lowercase letter, and one digit
    String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
    RegExp regExp = RegExp(passwordRegex);
    return regExp.hasMatch(password);
  }

  // Update User Type Selector

  // Sign The User '
  login(BuildContext context) async {
    if (signInformKey.currentState!.validate()) {
      try {
        isLoading = true;
        update();
        user = await UserProvider().loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        //await box.write(kUserToken, user.token);
        Get.toNamed(Routes.HOME);
        // log("UserToken From Local is : ${box.read(kUserToken)}");
        emailController.clear();
        passwordController.clear();
      } catch (e) {
        log("Error Login ${e}", name: "Login Error");
        showToast(
          message: "${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: BAppColor.kCheckOutInActiveBgColor,
          textColor: BAppColor.kCheckOutActiveTextColor,
        );
      }
      isLoading = false;
      update();
    } else {
      log("All Feilds Are Required", name: "When User is login");
      showToast(
        message: "Please All Feilds Are Required!.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    }
    isLoading = false;
    update();
  }

  // SignUp The User '
  registoCustomer(BuildContext context) async {
    if (customerInformKey.currentState!.validate()) {
      if (cusPassController.text != cusconfirmPasswordController.text) {
        showToast(
          message: "Password don't match! Please Check.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: BAppColor.kCheckOutInActiveBgColor,
          textColor: BAppColor.kCheckOutActiveTextColor,
        );
      } else {
        try {
          isCustomerLoading = true;
          update();
          customer = await UserProvider().registorUser(
            email: cusEmailController.text,
            password: cusPassController.text,
            name: cusnameController.text,
            phone: cusPhoneController.text,
          );
          showToast(
            message: "User Registeration Successfully Created",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: BAppColor.kcheckInInActiveBgColor,
            textColor: BAppColor.kCheckInActiveTextColor,
          );

          //await box.write(kUserToken, user.token);
          //Get.toNamed(Routes.USER);
          // log("UserToken From Local is : ${box.read(kUserToken)}");
          // cusEmailController.clear();
          // cusPassController.clear();
          // cusnameController.clear();
          // cusPhoneController.clear();
          // cusconfirmPasswordController.clear();
        } catch (e) {
          log("Error Registor ${e}", name: "Registor Error");
          showToast(
            message: "${e.toString()}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: BAppColor.kCheckOutInActiveBgColor,
            textColor: BAppColor.kCheckOutActiveTextColor,
          );
        }
        isCustomerLoading = false;
        update();
      }
    } else {
      log("All Feilds Are Required", name: "When User is Registor");
      showToast(
        message: "Please All Feilds Are Required!.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    }
    isCustomerLoading = false;
    update();
  }

  // Update Profile
  String messageIcon = "";
  updateUserProfile({String? name, String? email, String? phone}) async {
    try {
      isUserprofileLoading = true;
      isSocket = false;
      update();
      // users =

      user = await UserProvider().updateUserProfile(
        name: name.toString(),
        email: email.toString(),
        phone: phone.toString(),
      );

      update();
      showToast(
        message: "messageIcon",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kcheckInInActiveBgColor,
        textColor: BAppColor.kCheckInActiveTextColor,
      );

      // await Future.delayed(Duration(seconds: 2));

      // Get.back();
      // Reload user data to update UI
      //user = await UserProvider().savecurrentUser(currentUser);
      update();
    } on SocketException {
      isSocket = true;
      update();
      showToast(
        message: "Please, check your Internet Connection!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    } catch (e) {
      showToast(
        message: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );

      log("Error From When Updating User Profile ${e.toString()}",
          name: "Updating User Profile");
    }

    isUserprofileLoading = false;
    isSocket = false;
    update();
    // box.write('isLogging', true);
  }

  // logout() async {
  //   try {
  //     bool isSignedout = await UserProvider().userLogOut();
  //     if (isSignedout) {
  //       await box.remove(kUserInfo);
  //      // await box.remove(kUserToken);
  //       Get.offAllNamed(Routes.USER);
  //       showToast(
  //         message: BAllTexts.signOut,
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.SNACKBAR,
  //         backgroundColor: BAppColor.kcheckInInActiveBgColor,
  //         textColor: BAppColor.kCheckInActiveTextColor,
  //       );
  //     } else {}
  //   } catch (e) {
  //     showToast(
  //       message: "${e.toString()}",
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: BAppColor.kCheckOutInActiveBgColor,
  //       textColor: BAppColor.kCheckOutActiveTextColor,
  //     );
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    cusEmailController.dispose();
    cusPassController.dispose();
    cusnameController.dispose();
    cusPhoneController.dispose();
    cusconfirmPasswordController.dispose();
  }

  getUser() {
    try {
      if (box.hasData(kUserInfo)) {
        final json = box.read(kUserInfo);
        if (json != null) {
          user = UserModel.fromJson(json);
          print("${user.token}");
          update();
        }
      } else {
        // user = null;
        // update();
      }
    } catch (e, t) {
      print('GET USER ERROR : $e');
      print('GET USER TRUCE : $t');
    }
  }

  getCustomer() {
    try {
      if (box.hasData(kCustomerInfo)) {
        final json = box.read(kCustomerInfo);
        if (json != null) {
          customer = CustomerModel.fromJson(json);

          update();
        }
      } else {
        // user = null;
        // update();
      }
    } catch (e, t) {
      print('GET USER ERROR : $e');
      print('GET USER TRUCE : $t');
    }
  }
}
