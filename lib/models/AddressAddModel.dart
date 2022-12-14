// To parse this JSON data, do
//
//     final addressAddModel = addressAddModelFromJson(jsonString);

import 'dart:convert';

AddressAddModel addressAddModelFromJson(String str) =>
    AddressAddModel.fromJson(json.decode(str));

String addressAddModelToJson(AddressAddModel data) =>
    json.encode(data.toJson());

class AddressAddModel {
  AddressAddModel({
    this.mapCode,
    this.territory,
    this.houseNumber,
    this.streetName,
    this.physicalAddress,
    this.latitude,
    this.longitude,
    this.parish,
  });

  String? mapCode;
  String? territory;
  String? houseNumber;
  String? streetName;
  String? physicalAddress;
  int? latitude;
  int? longitude;
  int? parish;

  factory AddressAddModel.fromJson(Map<String, dynamic> json) =>
      AddressAddModel(
        mapCode: json["map_code"],
        territory: json["territory"],
        houseNumber: json["house_number"],
        streetName: json["street_name"],
        physicalAddress: json["physical_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        parish: json["parish"],
      );

  Map<String, dynamic> toJson() => {
        "map_code": mapCode,
        "territory": territory,
        "house_number": houseNumber,
        "street_name": streetName,
        "physical_address": physicalAddress,
        "latitude": latitude,
        "longitude": longitude,
        "parish": parish,
      };
}
