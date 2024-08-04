import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ewash/app/modules/user/model/customer_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/constants/api_or_keys_constants.dart';
import '../controllers/user_controller.dart';
import '../model/user_model.dart';

class UserProvider extends GetConnect {
  final box = GetStorage();

  loginUser({required String email, required String password}) async {
    var userData = {
      "email": email.toString(),
      "password": password.toString(),
    };

    // Send Data
    var response = await http.post(
      Uri.parse("${kEndPoint}auth/login"),
      body: userData,
      // headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    log("User Data ${userData}");
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      //log(decodeData.toString(), name: "DECODED");
      // log(decodeData['result'], name: "USER LOGIN DATA");
      if (!decodeData['status']) throw decodeData["message"];
      await box.write(kUserToken, decodeData['data']["token"]);
      log("User Token Saved ${box.read(kUserToken)}", name: "Token Data");
      await savecurrentUser(UserModel.fromJson(decodeData['data']));

      return UserModel.fromJson(decodeData['data']);
    } else {
      final decodeData = jsonDecode(response.body);
      throw decodeData['message'];
    }
  }

  registorUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    var userData = {
      "name": name.toString(),
      "email": email.toString(),
      "phone": phone.toString(),
      "password": password.toString()
      // "role":"customer"
    };

    // Send Data
    var response = await http.post(
      Uri.parse("${kEndPoint}auth/register"),
      body: userData,
      //headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    log("User Data ${userData}");
    if (response.statusCode == 201) {
      final decodeData = jsonDecode(response.body);
      log(decodeData.toString(), name: "DECODED");
      // log(decodeData['result'], name: "USER LOGIN DATA");
      if (!decodeData['status']) throw decodeData["message"];
      await savecustomerData(CustomerModel.fromJson(decodeData['data']));

      return CustomerModel.fromJson(decodeData['data']);
    } else {
      final decodeData = jsonDecode(response.body);

      throw decodeData['message'];
    }
  }

  // Update User Data
  // Update User Profile

  updateUserProfile({String? name, String? email, String? phone}) async {
    final user = Get.find<UserController>();

    if (!user.isSignIn) throw "Please make login first";
    var data = {"name": name, "email": email, "phone": phone};

    var response = await http.patch(
      Uri.parse("${kEndPoint}users/${user.user.id}"),
      body: data,
      // encoding: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      log(response.body, name: "Updated User data");

      final decodeData = jsonDecode(response.body);
      if (!decodeData['status']) throw decodeData["message"];
      log("${decodeData["message"]}");
      // Fetch updated user data from the server

      // Update local storage with the updated user data
      await savecurrentUser(
        UserModel(
          id: decodeData['data']["_id"],
          name: decodeData['data']["name"],
          email: decodeData['data']["email"],
          phone: decodeData['data']["phone"],
          role: decodeData['data']["role"],
          status: decodeData['data']["status"],
          token: box.read(kUserToken),
        ),
      );

      return UserModel(
        id: decodeData['data']["_id"],
        name: decodeData['data']["name"],
        email: decodeData['data']["email"],
        phone: decodeData['data']["phone"],
      );
      //return decodeData["message"];
      //UserModel.fromJson(decodeData);
    } else {
      final decodeData = jsonDecode(response.body);
      throw decodeData['message'];
    }
  }

  // User Logout

  userLogOut() async {
    final user = Get.find<UserController>();
    if (!user.isSignIn) {
      throw "User  NOT FOUND";
    }
    var response = await http.post(
      Uri.parse("${kEndPoint}logout"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'authtoken': user.user.token ?? "",
      },
    );
    log("User Faile ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      final decodeData = jsonDecode(response.body);

      throw decodeData['message'];
    }
  }

  savecurrentUser(UserModel currentUser) async {
    try {
      await box.remove(kUserInfo);
      await box.write(kUserInfo, currentUser.toJson());
      log("Current User is Saved Success: ${currentUser.toJson()}");
      //await box.write(kUserInfo, currentUser.toJson());
    } catch (e) {
      print('SAVE USER ERROR : $e');
    }
  }

  savecustomerData(CustomerModel customer) async {
    try {
      await box.remove(kCustomerInfo);
      await box.write(kCustomerInfo, customer.toJson());
      log("Current Customer  is Saved Success: ${customer.toJson()}");
      //await box.write(kUserInfo, currentUser.toJson());
    } catch (e) {
      print('SAVE USER ERROR : $e');
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
