// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, duplicate_ignore

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:postman/AUTH/verification.dart';
import 'package:postman/AUTH/widgets/Header.dart';
import 'package:postman/controllers/LoadingController.dart';
import 'package:postman/widgets/CommonButton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/logged_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showProgress = true;
  late String tel;
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        backgroundColor: Colors.red,
        toolbarHeight: 220,
        elevation: 0,
        centerTitle: true,
        title: Header(text: "Login"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            )),
        child: Form(
            // key: formKey,
            child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.15,
                  left: size.height * 0.05,
                  right: size.height * 0.05,
                  bottom: size.height * 0.05),
              child: const Center(
                child: Text(
                  "An SMS Code will be sent to your phone to verify your phone number",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            // phonefield
            Container(
              padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  left: size.height * 0.05,
                  right: size.height * 0.05,
                  bottom: size.height * 0.01),
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                // color: Colors.redAccent,
                borderRadius: BorderRadius.circular(29),
              ),
              child: IntlPhoneField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 12),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(15)),
                ),
                initialCountryCode: 'UG',
                onChanged: (phone) {
                  tel = phone.completeNumber;
                },
              ),
            ),
            // buttons
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  left: size.height * 0.05,
                  right: size.height * 0.05,
                  bottom: size.height * 0.01),
              child: CommonButton(
                isClickable: showProgress,
                buttonTextWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "NEXT",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                  ],
                ),
               
                onTap: () {
                  // ignore: unnecessary_null_comparison
                  if (tel != null) {
                    loaderController.changeProgress(
                        true, "Sending verification code  $tel");
                    loggingIn(tel);
                    // controller.clear();
                  } else {
                    if (kDebugMode) {
                      print("invalid");
                    }
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  // loggingIn logic
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  loggingIn(String phone) async {
    var updatedTel = phone.replaceAll('+256', '0');

    Map data = {
      "phone": updatedTel,
    };
    if (kDebugMode) {
      print(data);
    }
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    LoggedInUser jsonResponse;

    var response = await http.post(
      Uri.parse("https://api.postman.ug/api/v1/phone-login/"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if (response.statusCode == 201) {
      jsonResponse = LoggedInUser.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print("Login response ${response.body}");
      }
      // show progress
      loaderController.changeProgress(false, "Sending verification code  $tel");
      //
      setState(() {
        showProgress = false;
      });

      if (jsonResponse != null) {
        // Save an integer value to 'userId' key.
        await prefs.setString('userId', jsonResponse.id);
        // setInt('userId', jsonResponse.id);
        final snackBar = SnackBar(
          content: Text("SMS sent to  " + jsonResponse.phone),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verification(
              number: phone,
              userid: LoggedInUser.fromJson(jsonDecode(response.body)).id,
            ),
          ),
        );
      }
    } else {
      loaderController.changeProgress(false, "Sending verification code  $tel");
      var errmsg = jsonDecode(response.body);
      loaderController
          .showErrorMsg("Login failed \n\n ${errmsg['non_field_errors'][0]}");
    }
  }
}
