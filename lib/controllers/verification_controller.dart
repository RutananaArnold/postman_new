// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postman/controllers/Globals.dart';
import 'package:postman/controllers/LoadingController.dart';
import '../AUTH/complete_profile.dart';
import '../models/verify_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';

final verifyController = Get.put(VerifyController());

class VerifyController extends GetxController {
  String phone = " ";
  int code = 0;
  String id = " ";
  // verification logic
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };
// verificationResponseFromJson`
  verification(BuildContext context, phone, code, id) async {
    Map data = {
      "phone": phone,
      "code": code,
    };

    if (kDebugMode) {
      print("innerId $id");
    }
    final prefs = await SharedPreferences.getInstance();
    // ignore: prefer_typing_uninitialized_variables
    VerificationResponse jsonResponse;
    var response = await http.post(
      Uri.parse("https://api.postman.ug/api/v1/phone-login/$id/verify/"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if (response.statusCode == 200) {
      loaderController.changeProgress(false, " verifying  $phone");
      loaderController.showSuccess("Verification successful");

      print("Verification reply: ${jsonDecode(response.body)}");

      jsonResponse = VerificationResponse.fromJson(jsonDecode(response.body));
      global.setValue("user", response.body);
      // setting the token
      prefs.setInt("CustomerId", jsonResponse.customer.id);
      global.setValue("token", jsonResponse.token);
      // if (jsonResponse.isNull) {
      showSnackBar(context);
      navigate(context);
      // }

    } else {
      loaderController.changeProgress(false, " verifying  $phone");
      var errmsg = jsonDecode(response.body);
      loaderController.showErrorMsg(
          "Verification failed \n\n ${errmsg['non_field_errors'][0]}");
    }
    update();
  }
}

// 0752185104
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
const snackBar = SnackBar(
  content: Text("Verified Successfully  Enjoy!!"),
);
showSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

navigate(BuildContext context) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const CompleteProfile()),
      (route) => false);
}
