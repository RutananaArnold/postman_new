// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:postman/controllers/verification_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/LoadingController.dart';
import '../widgets/CommonButton.dart';
import 'widgets/Header.dart';

class Verification extends StatefulWidget {
  String? number;
  String userid;
  Verification({Key? key, this.number, required this.userid}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final pinputController = TextEditingController();

  late String verifyCode;
  late String tel;

// end of verification
  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            // size: 35,
          ),
        ),
        backgroundColor: Colors.red,
        toolbarHeight: 230,
        elevation: 0,
        centerTitle: true,
        title: Header(
          text: "Verification",
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.11,
                  left: size.height * 0.07,
                  right: size.height * 0.07,
                  bottom: size.height * 0.05),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "Phone Number Verification" "\n",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: "Enter the code sent to ${widget.number}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // textfield
            buildPinPut(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RichText(
                  text: const TextSpan(
                      text: "Didn't Receive Code? ",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.black54),
                      children: [WidgetSpan(child: Text("Resend"))]),
                ),
              ),
            ),
            // buttons
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  left: size.height * 0.04,
                  right: size.height * 0.04,
                  bottom: size.height * 0.05),
              child: CommonButton(
                buttonTextWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "VERIFY",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                  ],
                ),
                height: size.height * 0.09,
                onTap: () {
                  //logic for verfying
                  setState(() {
                    verifyCode = pinputController.text;
                  });
                  loaderController.changeProgress(
                      true, " verifying  ${widget.number.toString()}");

                  verifyController.verification(
                      context,
                      widget.number.toString().replaceAll('+256', '0'),
                      verifyCode,
                      widget.userid);
                },
              ),
            ),
            const Center(
              child: Text(
                "OR",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: CommonButton(
                backgroundColor: Colors.green,
                height: size.height * 0.09,
                onTap: () {
                  if (kDebugMode) {
                    print(widget.number);
                  }
                  Navigator.of(context).pop(widget.number);
                },
                buttonTextWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "Change Number",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.phone, color: Colors.white)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromARGB(255, 167, 184, 197),
      ),
    );

    return Pinput(
      length: 5,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      listenForMultipleSmsOnAndroid: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      controller: pinputController,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
    );
  }
}
