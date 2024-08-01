import 'dart:developer';
import 'dart:io';

import 'package:ewash/app/modules/booking/views/booking_view.dart';
import 'package:ewash/app/modules/favorate/views/favorate_view.dart';
import 'package:ewash/app/modules/home/model/services_providers_model.dart';
import 'package:ewash/app/modules/home/model/services_types_model.dart';
import 'package:ewash/app/modules/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../profile/views/profile_view.dart';
import '../views/tabs/home_tab.dart';

class HomeController extends GetxController {
  bool isServiceTypesLoading = false;
  bool isServiceProviderLoading = false;
  bool isServiceBookingLoading = false;
  bool isSocket = false;
  bool isTimeOut = false;
  List<ServiceTypesModel> serviceTypes = [];
  List<ServiceProvidersModel> serProviders = [];
  final box = GetStorage();
  DateTime? _currentBackPressTime;
  int currentTab = 0;
  final bookingformKey = GlobalKey<FormState>();
  final TextEditingController phnoneController = TextEditingController();
  String initialCountry = 'SO';
  String numberValue = "";
  PhoneNumber number = PhoneNumber(isoCode: 'SO');
  List<Widget> tabs = [
    const HomePage(),
    const BookingView(),
    const FavorateView(),
    const ProfileView(),
  ];
  // Update Current Tap
  updateCurrentTab(int index) {
    currentTab = index;
    update();
  }

  // Get Services Types
  displayServicesTypes() async {
    isServiceTypesLoading = true;
    isSocket = false;
    update();
    try {
      var data = await HomeProvider().getAllServicesTypes();

      //Get.off(() => HomeView());
      List newData = data;
      serviceTypes = newData.map((e) => ServiceTypesModel.fromJson(e)).toList();
      update();
      //weeklyData = data;
      //data.map((e) => WeeklyReportModel.fromJson(e)).toList();
      print("Services Types:  ${serviceTypes[0].name}");
    } on SocketException {
      showToast(
        message: "Please, check your Internet Connection!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
      isSocket = true;
      update();
    } catch (e) {
      //showMessage(e.toString());
      log(e.toString(), name: "Get weekly report");
    } finally {
      isServiceTypesLoading = false;
      isSocket = false;
      update();
    }
  }

  // Get Services Types
  displayServiceProviders() async {
    isServiceProviderLoading = true;
    isSocket = false;
    update();
    try {
      var data = await HomeProvider().getAllServiceProviders();

      //Get.off(() => HomeView());
      List newData = data;
      serProviders =
          newData.map((e) => ServiceProvidersModel.fromJson(e)).toList();
      update();
      //weeklyData = data;
      //data.map((e) => WeeklyReportModel.fromJson(e)).toList();
      print(
          "Services Types:  ${serProviders[0].serviceType?.name ?? "Salim Dhaalle"}");
    } on SocketException {
      showToast(
        message: "Please, check your Internet Connection!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
      isSocket = true;
      update();
    } catch (e) {
      //showMessage(e.toString());
      log(e.toString(), name: "Get All Service Providers");
    } finally {
      isServiceProviderLoading = false;
      isSocket = false;
      update();
    }
  }

  // Make Booking for Service Provider
  makeBookingService(ServiceProvidersModel service) async {
    bookingformKey.currentState!.save();
    if (bookingformKey.currentState?.validate() ?? false) {
      log("Service Name : ${service.carType?.type ?? ""}Service Id${service.sId} and Phone Number is : ${phnoneController.text}",
          name: "Making New Booking");
      isServiceBookingLoading = true;
      isSocket = false;
      update();
      try {
        var data = await HomeProvider().createServiceProviderBooking(
          service: service,
          phone: phnoneController.text.trim(),
        );

        log("${data.toString()}", name: "Hey");
        showToast(
          message: "${data}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: BAppColor.kcheckInInActiveBgColor,
          textColor: BAppColor.kCheckInActiveTextColor,
        );
        //phnoneController.clear();

        //Get.off(() => HomeView());
        // List newData = data;
        // serProviders =
        //     newData.map((e) => ServiceProvidersModel.fromJson(e)).toList();
        // update();
        //weeklyData = data;
        //data.map((e) => WeeklyReportModel.fromJson(e)).toList();
      } on SocketException {
        showToast(
          message: "Please, check your Internet Connection!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: BAppColor.kCheckOutInActiveBgColor,
          textColor: BAppColor.kCheckOutActiveTextColor,
        );
        isSocket = true;
        update();
      } catch (e) {
        showToast(
          message: "${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: BAppColor.kCheckOutInActiveBgColor,
          textColor: BAppColor.kCheckOutActiveTextColor,
        );
        log(e.toString(), name: "Make Service Pro Booking");
      } finally {
        isServiceBookingLoading = false;
        isSocket = false;
        update();
      }
    } else {
      showToast(
        message: "Please, Phone Number is required.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phnoneController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    displayServicesTypes();
    displayServiceProviders();
  }

  Future<bool> exit() async {
    DateTime now = DateTime.now();

    if (currentTab == 0) {
      if (_currentBackPressTime == null ||
          now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
        _currentBackPressTime = now;

        showToast(
          message: "Press back again to exit",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: BAppColor.kCheckOutInActiveBgColor,
          textColor: BAppColor.kCheckOutActiveTextColor,
        );

        return Future.value(false);
      } else {
        // onWillPop.call();
      }
      return Future.value(true);
    } else if (currentTab == 1) {
      currentTab = 0;
      update();
      return Future.value(false);
    } else if (currentTab == 2) {
      currentTab = 0;
      update();
      return Future.value(false);
    } else {
      currentTab = 0;
      update();
      return Future.value(false);
    }
  }
}
