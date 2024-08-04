import 'dart:convert';
import 'package:ewash/utils/constants/api_or_keys_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../user/controllers/user_controller.dart';

class BookingProvider extends GetConnect {
  getUserBookings() async {
    final user = Get.find<UserController>();
    if (!user.isSignIn) throw "Please login first to make booking";

    var response = await http.get(
      Uri.parse("${kEndPoint}bookings/my-bookings/${user.user.id}"),
    );
    // log("Sending Data${response.body}");

    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);

      if (!decodeData['status']) throw decodeData["message"];
      //log("User Bookings Data are : ${decodeData["data"]}");
      return decodeData["data"];
    } else {
      final decodeData = jsonDecode(response.body);

      throw decodeData['message'];
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
