import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postman/models/address_code_resp.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:postman/models/Couriers.dart';
import 'package:postman/widgets/rounded_button.dart';
import 'package:postman/widgets/rounded_input_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:postman/widgets/search_delegate.dart';

import '../controllers/Globals.dart';

import '../widgets/DropDown.dart';
import '../widgets/Space.dart';

class PanelBody extends StatefulWidget {
  final ScrollController controller;
  const PanelBody({Key? key, required this.controller}) : super(key: key);

  @override
  State<PanelBody> createState() => _PanelBodyState();
}

class _PanelBodyState extends State<PanelBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressCode();
  }

  String? selected;
  final destAddressCodeController = TextEditingController();
  final receipientController = TextEditingController();
  late String tel;
  final packageDescController = TextEditingController();
  final deliveryNotesController = TextEditingController();
  final pickupController = TextEditingController();
  final courierController = TextEditingController();

  Future<AddressCodeResponse> getAddressCode() async {
    String? token = await global.getValue("token");
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    AddressCodeResponse jsonResponse;
    var response = await http.get(
        Uri.parse('https://api.postman.ug/api/v1/addresses/'),
        headers: header);
    if (response.statusCode == 200) {
      jsonResponse = AddressCodeResponse.fromJson(jsonDecode(response.body));
      // print(response.body);
      // print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load AddressCodeResponse');
    }
  }

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

// fetch available couriers
  Future<List<String>> fetchCouriers() async {
    String? token = await global.getValue("token");
    headers["Authorization"] = "Bearer $token";

    Client client = Client();
    var response = await client.get(
        Uri.parse("https://api.postman.ug/api/v1/couriers/"),
        headers: headers);
    var temp = fetchAllCouriers(jsonDecode(response.body));

    return List.generate(temp.length, (index) => temp[index].name);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formkey = GlobalKey<FormState>();
    return SingleChildScrollView(
      controller: widget.controller,
      child: Form(
        key: formkey,
        child: Column(
          // padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 36,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_up_outlined)),
            ),
            RoundedInputField(
              label: "Destination Address Code",
              mustIcon: Icons.star,
              controller: destAddressCodeController,
              hintText: "Enter Destination code",
              readOnly: true,
              onTap: () {
                createAlert(context);
                // showSearch(
                //   context: context,
                //   delegate: CustomSearchDelegate(),
                // );
              },
              onChanged: (String? value) {},
              postfixIcon: const Icon(Icons.arrow_drop_down_outlined),
            ),
            RoundedInputField(
                label: "Receipient Names",
                mustIcon: Icons.star,
                controller: receipientController,
                hintText: "Enter Receipient Names"),
            // phonefield
            Container(
              padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  left: size.height * 0.03,
                  right: size.height * 0.03,
                  bottom: size.height * 0.01),
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(29),
              ),
              child: IntlPhoneField(
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
            RoundedInputField(
                label: "Package Description",
                mustIcon: Icons.star,
                controller: packageDescController,
                hintText: "Enter Package Description"),
            RoundedInputField(
                label: "Delivery Notes",
                mustIcon: Icons.star,
                controller: deliveryNotesController,
                hintText: "Enter Delivery Notes"),
            RoundedInputField(
                label: "Pickup Address",
                mustIcon: Icons.star,
                controller: pickupController,
                hintText: "Enter Pickup Address"),
            // RoundedInputField(
            //     label: "Courier",
            //     mustIcon: Icons.star,
            //     controller: courierController,
            //     hintText: "Choose Courier"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<String>?>(
                  future: fetchCouriers(),
                  builder: (context, snapshot) {
                    var couriers = snapshot.data;
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : DropDownWidget(
                            displayText: selected ?? couriers![0],
                            selectedValue: (value) async {
                              // int id =
                              //     await getParishId(value!);
                              setState(() {
                                selected = value!;
                                // parish = id;
                                if (kDebugMode) {
                                  // print(selected);
                                }
                              });
                            },
                            titleText: "Couriers",
                            elements: couriers!,
                          );
                  }),
            ),
            Space(),
            RoundedButton(text: "SUBMIT", press: () {}, color: Colors.grey),
            const SizedBox(
              height: 36,
            ),
          ],
        ),
      ),
    );
  }

  createAlert(BuildContext context) {
    String pickedCode = ' ';
    Future<AddressCodeResponse> getAddressCode() async {
      String? token = await global.getValue("token");
      Map<String, String> header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      AddressCodeResponse jsonResponse;
      var response = await http.get(
          Uri.parse(
              'https://api.postman.ug/api/v1/addresses/?map_code==$pickedCode'),
          headers: header);
      if (response.statusCode == 200) {
        jsonResponse = AddressCodeResponse.fromJson(jsonDecode(response.body));
        print(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to load AddressCodeResponse');
      }
    }

    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: RoundedInputField(
              label: "Address Code",
              mustIcon: Icons.star,
              hintText: "Input Address Code to search",
              onChanged: (String? value) {
                setState(() {
                  pickedCode = value!;
                });
                getAddressCode();
              },
            ),
            content: StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    FutureBuilder<AddressCodeResponse>(
                        future: getAddressCode(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.results[0].mapCode);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator.adaptive();
                        }))
                  ]),
                );
              },
            ),
          );
        });
  }
}
