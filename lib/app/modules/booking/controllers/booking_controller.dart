import 'dart:developer';
import 'dart:io';

import 'package:ewash/app/modules/booking/model/user_bookings_model.dart';
import 'package:ewash/app/modules/booking/providers/booking_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../../../utils/constants/app_colors.dart';

class BookingController extends GetxController {
  bool isBookingLoading = false;
  bool isSocket = false;
  bool isTimeOut = false;

  List<UserBookingsModel> booking = [];

  // Get user Booking From Database

  userBookings() async {
    try {
      if (booking.isEmpty) {
        isBookingLoading = true;
        update();
      }
      List bookingData = await BookingProvider().getUserBookings();
      booking =
          bookingData.map((data) => UserBookingsModel.fromJson(data)).toList();

      update();
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
      log(e.toString(), name: "Get All Service Providers");
      showToast(
        message: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: BAppColor.kCheckOutInActiveBgColor,
        textColor: BAppColor.kCheckOutActiveTextColor,
      );
    }
    isBookingLoading = false;
    isSocket = false;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    userBookings();
  }
}
