// To parse this JSON data, do
//
//     final couriers = couriersFromJson(jsonString);

import 'dart:convert';

// Couriers couriersFromJson(String str) => Couriers.fromJson(json.decode(str));
List<Result> fetchAllCouriers(Map<String, dynamic> json) =>
    List<Result>.from(json["results"].map((x) => Result.fromJson(x)));
String couriersToJson(Couriers data) => json.encode(data.toJson());

class Couriers {
  Couriers({
    required this.results,
  });

  List<Result> results;

  factory Couriers.fromJson(Map<String, dynamic> json) => Couriers(
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
    required this.name,
    required this.phone,
    required this.location,
    required this.createdById,
  });

  int id;
  String createdAt;
  CreatedBy createdBy;
  dynamic oldApiId;
  String name;
  String phone;
  String location;
  int createdById;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: json["created_at"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        oldApiId: json["old_api_id"],
        name: json["name"],
        phone: json["phone"],
        location: json["location"],
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "created_by": createdBy.toJson(),
        "old_api_id": oldApiId,
        "name": name,
        "phone": phone,
        "location": location,
        "created_by_id": createdById,
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
