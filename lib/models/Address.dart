// To parse this JSON data, do
//
//     final addresses = addressesFromJson(jsonString);

// ignore_for_file: constant_identifier_names, unnecessary_null_in_if_null_operators

import 'dart:convert';

List<Result> addressesFromJson(Map<String, dynamic> json) =>
    List<Result>.from(json["results"].map((x) => Result.fromJson(x)));

String addressesToJson(Addresses data) => json.encode(data.toJson());

class Addresses {
  Addresses({
    required this.results,
  });

  List<Result> results;

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.oldApiId,
    required this.mapCode,
    required this.territory,
    required this.parish,
    required this.houseNumber,
    required this.streetName,
    required this.physicalAddress,
    required this.latitude,
    required this.longitude,
    required this.createdById,
    required this.parishId,
  });

  int id;
  DateTime createdAt;
  CreatedBy createdBy;
  dynamic oldApiId;
  String mapCode;
  Territory? territory;
  Parish parish;
  String houseNumber;
  String streetName;
  String physicalAddress;
  double latitude;
  double longitude;
  int createdById;
  int parishId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: CreatedBy.fromJson(json["created_by"]),
        oldApiId: json["old_api_id"],
        mapCode: json["map_code"],
        territory: territoryValues.map[json["territory"]],
        parish: Parish.fromJson(json["parish"]),
        houseNumber: json["house_number"] ?? null,
        streetName: json["street_name"],
        physicalAddress: json["physical_address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        createdById: json["created_by_id"],
        parishId: json["parish_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy.toJson(),
        "old_api_id": oldApiId,
        "map_code": mapCode,
        "territory": territoryValues.reverse![territory],
        "parish": parish.toJson(),
        "house_number": houseNumber,
        "street_name": streetName,
        "physical_address": physicalAddress,
        "latitude": latitude,
        "longitude": longitude,
        "created_by_id": createdById,
        "parish_id": parishId,
      };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.username,
    required this.getFullName,
  });

  int id;
  String username;
  String getFullName;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        username: json["username"],
        getFullName: json["get_full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "get_full_name": getFullName,
      };
}

class Parish {
  Parish({
    required this.id,
    required this.oldApiId,
    required this.postCode,
    required this.name,
    required this.districtName,
    required this.countyName,
    required this.subCountyName,
  });

  int id;
  dynamic oldApiId;
  String postCode;
  String name;
  String districtName;
  String countyName;
  String subCountyName;

  factory Parish.fromJson(Map<String, dynamic> json) => Parish(
        id: json["id"],
        oldApiId: json["old_api_id"],
        postCode: json["post_code"] ?? null,
        name: json["name"],
        districtName: json["district_name"],
        countyName: json["county_name"],
        subCountyName: json["sub_county_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "old_api_id": oldApiId,
        "post_code": postCode,
        "name": name,
        "district_name": districtName,
        "county_name": countyName,
        "sub_county_name": subCountyName,
      };
}

enum Territory { UGA }

final territoryValues = EnumValues({"UGA": Territory.UGA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
