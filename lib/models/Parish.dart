// To parse this JSON data, do
//
//     final parish = parishFromJson(jsonString);

import 'dart:convert';

Parish parishFromJson(String str) => Parish.fromJson(json.decode(str));

String parishToJson(Parish data) => json.encode(data.toJson());

class Parish {
  Parish({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.next,
    this.previous,
    required this.results,
  });

  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  String? next;
  dynamic previous;
  List<Result> results;

  factory Parish.fromJson(Map<String, dynamic> json) => Parish(
        total: json["total"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

List<Result> fetchResponseFromJson(Map<String, dynamic> json) =>
    List<Result>.from(json["results"].map((x) => Result.fromJson(x)));

class Result {
  Result({
    required this.id,
    this.createdAt,
    this.createdBy,
    this.oldApiId,
    required this.postCode,
    required this.name,
    required this.subCounty,
    this.districtName,
    this.countyName,
    required this.subCountyName,
    this.createdById,
    required this.subCountyId,
  });

  int id;
  DateTime? createdAt;
  dynamic createdBy;
  dynamic oldApiId;
  String postCode;
  String name;
  SubCounty subCounty;
  Name? districtName;
  Name? countyName;
  String subCountyName;
  dynamic createdById;
  int subCountyId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        oldApiId: json["old_api_id"],
        postCode: json["post_code"],
        name: json["name"],
        subCounty: SubCounty.fromJson(json["sub_county"]),
        districtName: nameValues.map[json["district_name"]],
        countyName: nameValues.map[json["county_name"]],
        subCountyName: json["sub_county_name"],
        createdById: json["created_by_id"],
        subCountyId: json["sub_county_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "created_by": createdBy,
        "old_api_id": oldApiId,
        "post_code": postCode,
        "name": name,
        "sub_county": subCounty.toJson(),
        "district_name": nameValues.reverse![districtName],
        "county_name": nameValues.reverse![countyName],
        "sub_county_name": subCountyName,
        "created_by_id": createdById,
        "sub_county_id": subCountyId,
      };
}

// ignore: constant_identifier_names
enum Name { RUKIGA, BULAMBULI, COUNTY }

final nameValues = EnumValues({
  "Bulambuli": Name.BULAMBULI,
  "County": Name.COUNTY,
  "Rukiga": Name.RUKIGA
});

class SubCounty {
  SubCounty({
    this.id,
    this.oldApiId,
    this.name,
  });

  int? id;
  dynamic oldApiId;
  String? name;

  factory SubCounty.fromJson(Map<String, dynamic> json) => SubCounty(
        id: json["id"],
        oldApiId: json["old_api_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "old_api_id": oldApiId,
        "name": name,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
