// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postman/models/Address.dart';
import 'package:postman/widgets/Space.dart';

import '../controllers/Globals.dart';

class Addresses extends StatefulWidget {
  const Addresses({Key? key}) : super(key: key);

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  // function to return available addresses
  Future<List<Result>> getAddresses() async {
    String? token = await global.getValue("token");
    http.Client client = http.Client();

    Map<String, String> heads = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };

    heads["Authorization"] = "Bearer $token";
    var response = await client.get(
        Uri.parse("https://api.postman.ug/api/v1/addresses/"),
        headers: heads);
    return addressesFromJson(jsonDecode(response.body));
  }

  @override
  void initState() {
    super.initState();
    getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Result>>(
        future: getAddresses(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: Column(
                    children: [
                      Space(
                        space: 0.5,
                      ),
                      const CircularProgressIndicator.adaptive(),
                      Space(),
                      const Text("Loading addresses, please wait..."),
                    ],
                  ),
                )
              : RenderAddresses(results: snapshot.data);
        },
      ),
    );
  }
}

class RenderAddresses extends StatefulWidget {
  List<Result>? results;
  RenderAddresses({Key? key, this.results}) : super(key: key);

  @override
  State<RenderAddresses> createState() => _RenderAddressesState();
}

class _RenderAddressesState extends State<RenderAddresses> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.location_on),
              title: RichText(
                  text: TextSpan(
                      text:
                          'National PostCode: ${widget.results![index].parish.postCode}' +
                              "\n",
                      style: const TextStyle(color: Colors.black),
                      children: [
                    TextSpan(
                      text: 'Address Code: ${widget.results![index].mapCode}' +
                          "\n",
                      style: const TextStyle(color: Colors.black),
                    )
                  ])),
              subtitle: RichText(
                  text: TextSpan(
                      text:
                          'House Number: ${widget.results![index].houseNumber}' +
                              "\n",
                      style: const TextStyle(color: Colors.black),
                      children: [
                    TextSpan(
                      text:
                          'Street Name: ${widget.results![index].streetName}' +
                              "\n",
                      style: const TextStyle(color: Colors.black),
                    )
                  ])),
            ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: widget.results!.length);
  }
}
