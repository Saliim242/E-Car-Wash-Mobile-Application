import 'dart:convert';
import 'dart:developer';
import 'package:ewash/app/modules/home/model/services_providers_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../user/controllers/user_controller.dart';

class HomeProvider extends GetConnect {
  getAllServicesTypes() async {
    // Send Data
    var response = await http.get(
      Uri.parse("${kEndPoint}service-types"),
    );

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      //log(decodeData.toString(), name: "Services Type");
      if (!decodeData['status']) throw decodeData["message"];
      //log("${decodeData["data"]["docs"].toString()}");
      return decodeData["data"]["docs"];
    } else {
      final decodeData = jsonDecode(response.body);
      throw decodeData['message'];
    }
  }

  //getAll Services Providers

  getAllServiceProviders() async {
    var response = await http.get(
      Uri.parse(
        "${kEndPoint}services?options[populate][0][path]=serviceType&options[populate][0][dir]=serviceTypes&options[populate][1][path]=carType&options[populate][1][dir]=carTypes&options[limit]=100",
      ),
    );

    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      if (!decodeData['status']) throw decodeData["message"];
      // log("${decodeData["data"]["docs"].toString()}",
      //     name: "Services Providers");
      return decodeData["data"]["docs"];
    } else {
      final decodeData = jsonDecode(response.body);
      throw decodeData['message'];
    }
  }

  /// Calling Making Booking API
  createServiceProviderBooking({
    required ServiceProvidersModel service,
    required String phone,
  }) async {
    final user = Get.find<UserController>();
    if (!user.isSignIn) throw "Please login first to make booking";
    var bookingData = {
      "user": user.user.id,
      "service": service.sId,
      "phoneNumber": phone
    };

    // Send Data
    var response = await http.post(
      Uri.parse("${kEndPoint}bookings/send"),
      body: bookingData,
      //headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    log("User Data ${bookingData}");
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      log(decodeData.toString(), name: "Service Booking");

      if (!decodeData['status']) throw decodeData["message"];

      return decodeData["message"];
    } else {
      final decodeData = jsonDecode(response.body);

      throw decodeData['message'];
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
    getAllServicesTypes();
  }
}
