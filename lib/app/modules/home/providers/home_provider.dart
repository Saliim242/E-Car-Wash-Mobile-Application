import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ewash/app/modules/home/model/review_model.dart';
import 'package:ewash/app/modules/home/model/services_providers_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/constants/api_or_keys_constants.dart';
import '../../user/controllers/user_controller.dart';

class HomeProvider extends GetConnect {
  // Get All Service Type
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
  // createServiceProviderBooking({
  //   required ServiceProvidersModel service,
  //   required String phone,
  //   required String dateTime,
  // }) async {
  //   final user = Get.find<UserController>();
  //   if (!user.isSignIn) throw "Please login first to make booking";
  //   var bookingData = {
  //     "user": user.user.id,
  //     "service": service.sId,
  //     "phoneNumber": phone,
  //     "dateTime": dateTime,
  //   };

  //   // Send Data
  //   var response = await http.post(
  //     Uri.parse("${kEndPoint}bookings/send"),
  //     body: jsonEncode(bookingData),
  //     headers: {
  //       HttpHeaders.contentTypeHeader: "application/json",
  //     },
  //     // body: bookingData,
  //     //headers: {HttpHeaders.contentTypeHeader: "application/json"},
  //   );
  //   log("User Data ${bookingData}");
  //   if (response.statusCode == 200) {
  //     log(response.body, name: "Response Body");
  //     final decodeData = jsonDecode(response.body);
  //     log(decodeData.toString(), name: "Service Booking");

  //     if (!decodeData['status']) throw decodeData["message"];

  //     return decodeData["message"];
  //   } else {
  //     final decodeData = jsonDecode(response.body);

  //     throw decodeData['message'];
  //   }
  // }
  // NEW FROM CHAPT
  /// Calling Making Booking API
  createServiceProviderBooking({
    required ServiceProvidersModel service,
    required String phone,
    required String dateTime,
  }) async {
    final user = Get.find<UserController>();
    if (!user.isSignIn) throw "Please login first to make booking";

    var bookingData = {
      "user": user.user.id,
      "service": service.sId,
      "phoneNumber": phone,
      "dateTime": dateTime,
    };

    // Send Data
    var response = await http.post(
      Uri.parse("${kEndPoint}bookings/send"),
      body: bookingData,
      // headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      // },
    );
    log("User Data ${bookingData}");
    log("Raw Response: ${response.body}", name: "Response Body");
    log("Response Headers: ${response.headers.toString()}", name: "Headers");
    if (response.headers['content-type']?.contains('application/json') ==
        true) {
      if (response.statusCode == 200) {
        try {
          final decodeData = jsonDecode(response.body);
          log(decodeData.toString(), name: "Service Booking");
          if (!decodeData['status']) throw decodeData["message"];
          return decodeData["message"];
        } catch (e) {
          log("Error decoding JSON: $e", name: "JSON Decoding Error");
          throw "Failed to parse server response";
        }

        // log(response.body, name: "Response Body");
        // final decodeData = jsonDecode(response.body);
        // log(decodeData.toString(), name: "Service Booking");

        // if (!decodeData['status']) throw decodeData["message"];

        // return decodeData["message"];
      } else {
        final decodeData = jsonDecode(response.body);
        throw decodeData['message'];
      }
    } else {
      log("Unexpected response format: ${response.body}");
      throw "Unexpected response format";
    }
  }

  // Create Review

  createReviewService({
    required ServiceProvidersModel service,
    required String rating,
    required String comment,
  }) async {
    final user = Get.find<UserController>();
    if (!user.isSignIn) throw "Please login first to make booking";
    var reviewData = {
      "userId": user.user.id,
      "serviceId": service.sId,
      "rating": rating,
      "comment": comment,
    };

    var response = await http.post(
      Uri.parse("${kEndPoint}reviews"),
      body: reviewData,
    );
    log("You are sending ${reviewData}");
    log("Response Body Data ${response.body}");

    if (response.statusCode == 201) {
      var decodeData = jsonDecode(response.body);
      if (!decodeData["status"]) throw decodeData["message"];
      log("You Made Review for : ${decodeData["data"]}");

      return ReviewModel.fromJson(decodeData["data"]);
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
