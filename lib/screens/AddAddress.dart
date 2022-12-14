import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:postman/controllers/LoadingController.dart';
import 'package:postman/models/Parish.dart';
import 'package:postman/widgets/CommonButton.dart';
import 'package:postman/widgets/Common_text_input.dart';
import 'package:postman/widgets/DropDown.dart';
import 'package:postman/widgets/Space.dart';
import 'package:http/http.dart' as http;

import '../controllers/Globals.dart';
import 'index.dart';

class AddAdress extends StatefulWidget {
  const AddAdress({Key? key}) : super(key: key);

  @override
  State<AddAdress> createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  final houseController = TextEditingController();
  final streetController = TextEditingController();
  final locationController = TextEditingController();
  final parishController = TextEditingController();
  final territoryController = TextEditingController();

// initialize Geolocator
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  List fields = [
    {'label': "Territory"},
    {'label': "House Number"},
    {'label': 'Street Name'},
    {'label': 'Physical address'},
    {'label': 'Parish'}
  ];
  String? selected;
  int parish = 0;
  double long = 0.0, lat = 0.0;
// handle permissions
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  getLocation() {
    _handlePermission().then((bool hasPermission) {
      if (hasPermission) {
        _geolocatorPlatform.getCurrentPosition().then((Position position) {
          setState(() {
            lat = position.latitude;
            long = position.longitude;
          });
        });
      }
    });
  }

// method to get selected parish's id
  Future<int> getParishId(String parish) async {
    String? token = await global.getValue("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Client client = http.Client();
    var response = await client.get(
        Uri.parse("https://api.postman.ug/api/v1/parishes/"),
        headers: headers);
    var store = fetchResponseFromJson(jsonDecode(response.body));
    var result = store.firstWhere((element) => element.name == parish);
    return result.id;
  }

  Future<List<String>> fetchParishs() async {
    String? token = await global.getValue("token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Client client = http.Client();
    var response = await client.get(
        Uri.parse("https://api.postman.ug/api/v1/parishes/"),
        headers: headers);
    var store = fetchResponseFromJson(jsonDecode(response.body));
    return List.generate(store.length, (index) => store[index].name);
  }

// function to save new address
  Future<void> storeAddress(Map<String, dynamic> x) async {
    String? token = await global.getValue("token");
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Client client = http.Client();
    var response = await client.post(
        Uri.parse("https://api.postman.ug/api/v1/addresses/"),
        headers: header,
        body: jsonEncode(x),
        encoding: Encoding.getByName('utf-8'));

    loaderController.changeProgress(true, "Saving your data");
    if (response.statusCode == 200) {
      loaderController.changeProgress(false, "Saving your data");

      loaderController.showSuccess("Address added successfuly");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Index(), fullscreenDialog: true));
    } else {
      loaderController.changeProgress(false, "Saving your data");

      loaderController.showErrorMsg("Error in saving your address");
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> inputs = [
      territoryController,
      houseController,
      streetController,
      locationController,
      territoryController
    ];
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey[200],
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add Address'),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: List.generate(
              7,
              (index) => index == 0
                  ? Space(
                      space: 0.02,
                    )
                  : index == 6
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: CommonButton(
                              height: 58,
                              buttonText: "Submit",
                              onTap: () {
                                Map<String, dynamic> db = {
                                  "map_code": "string",
                                  "territory": territoryController.text,
                                  "house_number": houseController.text,
                                  "street_name": streetController.text,
                                  "physical_address": locationController.text,
                                  "latitude": lat,
                                  "longitude": long,
                                  "parish": parish
                                };
                                // global.setValue("lat", lat.toString());
                                // global.setValue("long", long.toString);
                                storeAddress(db);
                                for (var i = 0; i < inputs.length; i++) {
                                  inputs[i].clear();
                                }
                                if (kDebugMode) {
                                  print(db);
                                }
                              }),
                        )
                      : index == 5
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder<List<String>>(
                                  future: fetchParishs(),
                                  builder: (context, snapshot) {
                                    var parishs = snapshot.data;
                                    return snapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : DropDownWidget(
                                            displayText:
                                                selected ?? parishs![0],
                                            selectedValue: (value) async {
                                              int id =
                                                  await getParishId(value!);
                                              setState(() {
                                                selected = value;
                                                parish = id;
                                                if (kDebugMode) {
                                                  print(selected);
                                                }
                                              });
                                            },
                                            titleText: "Parish",
                                            elements: parishs!,
                                          );
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CommonTextFieldView(
                                hintText: "Enter ${fields[index - 1]['label']}",
                                titleText: fields[index - 1]['label'],
                                controller: inputs[index - 1],
                              ),
                            ),
            ),
          ),
        ),
      ),
    );
  }
}
