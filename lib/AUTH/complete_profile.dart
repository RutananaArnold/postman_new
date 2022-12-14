// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postman/screens/AddAddress.dart';
import 'package:postman/widgets/drawer_tile.dart';
import 'package:postman/widgets/rounded_input_field.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/Globals.dart';
import '../controllers/LoadingController.dart';
import '../widgets/CommonButton.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  // bool individualAccount = false;
  bool businessOpt = false;
  bool showProgress = true;
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  final TextEditingController bNameController = TextEditingController();
  final TextEditingController postionController = TextEditingController();
  final formkey = GlobalKey<FormFieldState>();
  int genderValue = 1;
  String genderName = " ";

  // date picker logic
  DateTime selectedDate = DateTime.now();
  // image functionality
  File? _image;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePickerGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _openImagePickerCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // end of image functionality
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        backgroundColor: Colors.red,
        middle: Text(
          "Complete Profile",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(height: size.height * 0.05),
            const Center(
                child: Text(
              "Almost done, Tell us more about yourself",
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.w800),
            )),
            SizedBox(height: size.height * 0.03),
            const Center(
                child: Text(
              "Profile Picture",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            )),
            SizedBox(height: size.height * 0.03),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              DrawerListTile(
                                  color: Colors.black,
                                  title: "Photo Library",
                                  svgSrc: Icons.image_search_rounded,
                                  press: () {
                                    _openImagePickerGallery();
                                  }),
                              DrawerListTile(
                                  color: Colors.black,
                                  title: "Camera",
                                  svgSrc: Icons.camera_alt,
                                  press: () {
                                    _openImagePickerCamera();
                                  }),
                            ],
                          ),
                        );
                      });
                },
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const Icon(Icons.photo_camera_front_outlined),
              ),
            ),
            //account type
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                        text: const TextSpan(
                            text: "Account Type  ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                            children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.red,
                          ))
                        ])),
                  ),
                  RollingSwitch.icon(
                    onChanged: (bool state) {
                      setState(() {
                        businessOpt = state;
                      });

                      if (kDebugMode) {
                        print("indivual turned  $businessOpt");
                        print("business turned  ${!businessOpt}");
                      }
                    },
                    rollingInfoRight: const RollingIconInfo(
                        icon: Icons.person,
                        text: Text('individual'),
                        backgroundColor: Colors.red),
                    rollingInfoLeft: const RollingIconInfo(
                      icon: Icons.business,
                      backgroundColor: Colors.grey,
                      text: Text('Business'),
                    ),
                  ),
                ],
              ),
            ),
            // accounttype ends
            fields(businessOpt),

            // start of gender fiel
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: const TextSpan(
                        text: "Gender  ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                        children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.red,
                          ))
                        ],
                      ),
                    ),
                  ),
                  Radio(
                      value: 1,
                      groupValue: genderValue,
                      onChanged: (int? value) {
                        setState(() {
                          genderValue = value!;
                          genderName = 'M';
                        });
                      }),
                  const Text('Male'),
                  const SizedBox(width: 20),
                  Radio(
                    value: 2,
                    groupValue: genderValue,
                    onChanged: (int? value) {
                      setState(() {
                        genderValue = value!;
                        genderName = 'F';
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
            ),

            // end of gender field
            SizedBox(height: size.height * 0.03),
            CommonButton(
              height: size.height * 0.09,
              buttonText: "SUBMIT",
              onTap: () {
                if (fNameController.text.isEmpty ||
                    lNameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    genderName.toString().isEmpty ||
                    dateController.text.isEmpty) {
                  const snackBar = SnackBar(
                    content: Text("Empty Field's Found"),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  print(businessOpt);
                  // should redirect to add addresses page
                  completeprofile(
                      fNameController.text,
                      lNameController.text,
                      phoneController.text,
                      emailController.text,
                      businessOpt,
                      genderName,
                      dateController.text,
                      !businessOpt,
                      businessOpt ? null : bNameController.text,
                      businessOpt ? null : postionController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // complete profile logic
  completeprofile(String fname, lname, tel, email, bool active, String gender,
      dob, bool isBusiness, String? businessName, businessPosition) async {
    Map data = {
      "first_name": fname,
      "last_name": lname,
      "phone_number": tel,
      "email": email,
      "active": active,
      "gender": gender,
      "dob": dob,
      "is_business": isBusiness,
      "business_name": businessName,
      "position_in_business": businessPosition,
    };
    if (kDebugMode) {
      print(data);
    }
    String? token = await global.getValue("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    var jsonResponse;

    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // Save an integer value to 'userId' key.
    int? storedCustomerId = prefs.getInt('CustomerId');
    String url = "https://api.postman.ug/api/v1/customers/$storedCustomerId/";
    var response = await http.patch(
      Uri.parse("$url"),
      body: jsonEncode(data),
      headers: headers,
    );
    print("$url");
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      // show progress
      loaderController.changeProgress(false, "Sending your data through");
      //
      setState(() {
        showProgress = false;
      });
      print(jsonResponse);
      final snackBar = SnackBar(
        content: Text("  $jsonResponse"),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddAdress()),
      );
    } else {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final snackBar = SnackBar(
        content: Text("  $jsonResponse"),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget fields(
    bool acc,
  ) {
    if (acc) {
      return Column(
        children: [
          RoundedInputField(
              label: "First Name",
              mustIcon: Icons.star,
              controller: fNameController,
              hintText: "Enter First Name"),
          RoundedInputField(
              label: "Last Name",
              mustIcon: Icons.star,
              controller: lNameController,
              hintText: "Enter Last Name"),
          RoundedInputField(
              label: "Phone",
              mustIcon: Icons.star,
              controller: phoneController,
              hintText: "Enter other phone number"),
          RoundedInputField(
              label: "Email",
              mustIcon: Icons.star,
              controller: emailController,
              hintText: "Enter Email"),
          RoundedInputField(
              label: "Date of Birth",
              mustIcon: Icons.star,
              controller: dateController,
              hintText: "e.g 2022-07-15"),
        ],
      );
    } else {
      return Column(
        children: [
          RoundedInputField(
              label: "Business Name",
              mustIcon: Icons.star,
              controller: bNameController,
              hintText: "Enter Business Name"),
          RoundedInputField(
              label: "First Name",
              mustIcon: Icons.star,
              controller: fNameController,
              hintText: "Enter First Name"),
          RoundedInputField(
              label: "Last Name",
              mustIcon: Icons.star,
              controller: lNameController,
              hintText: "Enter Last Name"),
          RoundedInputField(
              label: "Phone",
              mustIcon: Icons.star,
              controller: phoneController,
              hintText: "Enter other phone number"),
          RoundedInputField(
              label: "Position In Business",
              mustIcon: Icons.star,
              controller: postionController,
              hintText: "Enter Position In Business"),
          RoundedInputField(
              label: "Email",
              mustIcon: Icons.star,
              controller: emailController,
              hintText: "Enter Email"),
          RoundedInputField(
              label: "Date of Birth",
              mustIcon: Icons.star,
              controller: dateController,
              hintText: "e.g 2022-07-15"),
        ],
      );
    }
  }
}
