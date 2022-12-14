// To parse this JSON data, do
//
//     final packages = packagesFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<Result> packagesFromJson(Map<String, dynamic> json) =>
    List<Result>.from(json["results"].map((x) => Result.fromJson(x)));

String packagesToJson(Packages data) => json.encode(data.toJson());

class Packages {
  Packages({
    required this.results,
  });

  List<Result> results;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
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
    required this.courier,
    required this.packageNumber,
    required this.description,
    required this.senderName,
    required this.senderPhone,
    required this.recipientName,
    required this.recipientPhone,
    required this.source,
    required this.destination,
    required this.size,
    required this.locationSegment,
    required this.driver,
    required this.deliveryAmount,
    required this.isPayOnDelivery,
    required this.payOnDeliveryAmount,
    required this.totalAmount,
    required this.currentStatus,
    required this.statusHistory,
    required this.destinationDescription,
    required this.deliveryNotes,
    required this.route,
    required this.createdById,
    required this.courierId,
    required this.sourceId,
    required this.destinationId,
    required this.sizeId,
    required this.locationSegmentId,
    required this.driverId,
    required this.routeId,
  });

  int id;
  DateTime createdAt;
  CreatedBy createdBy;
  dynamic oldApiId;
  Courier courier;
  String packageNumber;
  String description;
  String senderName;
  String senderPhone;
  String recipientName;
  String recipientPhone;
  Destination? source;
  Destination? destination;
  Size size;
  Size? locationSegment;
  DriverClass? driver;
  int deliveryAmount;
  bool isPayOnDelivery;
  int payOnDeliveryAmount;
  int totalAmount;
  CurrentStatus? currentStatus;
  List<CurrentStatus>? statusHistory;
  String destinationDescription;
  String deliveryNotes;
  int route;
  int createdById;
  int courierId;
  int sourceId;
  int destinationId;
  int sizeId;
  int locationSegmentId;
  int driverId;
  int routeId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: CreatedBy.fromJson(json["created_by"]),
        oldApiId: json["old_api_id"],
        courier: Courier.fromJson(json["courier"]),
        packageNumber: json["package_number"],
        description: json["description"],
        senderName: json["sender_name"],
        senderPhone: json["sender_phone"],
        recipientName: json["recipient_name"],
        recipientPhone: json["recipient_phone"],
        source: json["source"] == null
            ? null
            : Destination.fromJson(json["source"]),
        destination: Destination.fromJson(json["destination"]),
        size: Size.fromJson(json["size"]),
        locationSegment: json["location_segment"] == null
            ? null
            : Size.fromJson(json["location_segment"]),
        driver: json["driver"] == null
            ? null
            : DriverClass.fromJson(json["driver"]),
        deliveryAmount: json["delivery_amount"],
        isPayOnDelivery: json["is_pay_on_delivery"],
        payOnDeliveryAmount: json["pay_on_delivery_amount"],
        totalAmount: json["total_amount"],
        currentStatus: CurrentStatus.fromJson(json["current_status"]),
        statusHistory: List<CurrentStatus>.from(
            json["status_history"].map((x) => CurrentStatus.fromJson(x))),
        destinationDescription: json["destination_description"],
        deliveryNotes: json["delivery_notes"],
        route: json["route"],
        createdById: json["created_by_id"],
        courierId: json["courier_id"],
        sourceId: json["source_id"],
        destinationId: json["destination_id"],
        sizeId: json["size_id"],
        locationSegmentId: json["location_segment_id"],
        driverId: json["driver_id"],
        routeId: json["route_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy.toJson(),
        "old_api_id": oldApiId,
        "courier": courier.toJson(),
        "package_number": packageNumber,
        "description": description,
        "sender_name": senderName,
        "sender_phone": senderPhone,
        "recipient_name": recipientName,
        "recipient_phone": recipientPhone,
        "source": source?.toJson(),
        "destination": destination?.toJson(),
        "size": size.toJson(),
        "location_segment": locationSegment?.toJson(),
        "driver": driver?.toJson(),
        "delivery_amount": deliveryAmount,
        "is_pay_on_delivery": isPayOnDelivery,
        "pay_on_delivery_amount": payOnDeliveryAmount,
        "total_amount": totalAmount,
        "current_status": currentStatus?.toJson(),
        "status_history":
            List<dynamic>.from(statusHistory!.map((x) => x.toJson())),
        "destination_description": destinationDescription,
        "delivery_notes": deliveryNotes,
        "route": route,
        "created_by_id": createdById,
        "courier_id": courierId,
        "source_id": sourceId,
        "destination_id": destinationId,
        "size_id": sizeId,
        "location_segment_id": locationSegmentId,
        "driver_id": driverId,
        "route_id": routeId,
      };
}

class Courier {
  Courier({
    required this.id,
    required this.oldApiId,
    required this.name,
    required this.phone,
    required this.location,
  });

  int id;
  dynamic oldApiId;
  Name? name;
  String phone;
  Location? location;

  factory Courier.fromJson(Map<String, dynamic> json) => Courier(
        id: json["id"],
        oldApiId: json["old_api_id"],
        name: nameValues.map[json["name"]],
        phone: json["phone"],
        location: locationValues.map[json["location"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "old_api_id": oldApiId,
        "name": nameValues.reverse[name],
        "phone": phone,
        "location": locationValues.reverse[location],
      };
}

enum Location { KAMPALA }

final locationValues = EnumValues({"Kampala": Location.KAMPALA});

enum Name { TEST_COURIER }

final nameValues = EnumValues({"Test Courier": Name.TEST_COURIER});

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

class CurrentStatus {
  CurrentStatus({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.oldApiId,
    required this.status,
    required this.statusId,
    required this.driver,
  });

  int id;
  DateTime createdAt;
  dynamic createdBy;
  dynamic oldApiId;
  Status? status;
  int statusId;
  DriverEnum? driver;

  factory CurrentStatus.fromJson(Map<String, dynamic> json) => CurrentStatus(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        oldApiId: json["old_api_id"],
        status: statusValues.map[json["status"]],
        statusId: json["status_id"],
        driver: json["driver"] == null
            ? null
            : driverEnumValues.map[json["driver"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "old_api_id": oldApiId,
        "status": statusValues.reverse[status],
        "status_id": statusId,
        "driver": driver == null ? null : driverEnumValues.reverse[driver],
      };
}

enum DriverEnum {
  THE_0706080109_ANTHONY_OSALIA,
  THE_0757111423_ANTHONY_ADOI,
  THE_0755656555_FRED_K,
  THE_0755332754_E_LUYIMA,
  THE_0787348240_FRANCIS_O,
  THE_0705203514_FRANCIS_OKWIR,
  THE_0785967991_TONNY_W
}

final driverEnumValues = EnumValues({
  "0705203514 - Francis Okwir": DriverEnum.THE_0705203514_FRANCIS_OKWIR,
  "0706080109 - Anthony Osalia": DriverEnum.THE_0706080109_ANTHONY_OSALIA,
  "0755332754 - E Luyima": DriverEnum.THE_0755332754_E_LUYIMA,
  "0755656555 - Fred K": DriverEnum.THE_0755656555_FRED_K,
  "0757111423 - Anthony Adoi": DriverEnum.THE_0757111423_ANTHONY_ADOI,
  "0785967991 - Tonny W": DriverEnum.THE_0785967991_TONNY_W,
  "0787348240 - Francis O": DriverEnum.THE_0787348240_FRANCIS_O
});

enum Status {
  PENDING,
  ASSIGNED_DRIVER_PICKUP,
  AT_HUB_READY_FOR_DELIVERY,
  PACKAGE_DELIVERED,
  ROUTE_ASSIGNED,
  DRIVER_ACCEPTED_PICKUP,
  ON_ROUTE_TO_WAREHOUSE,
  DRIVER_PICKED,
  DRIVER_ON_ROUTE_TO_PICKUP,
  DISPATCHED_FOR_DELIVERY,
  CAPTURED_AT_WAREHOUSE
}

final statusValues = EnumValues({
  "assigned driver pickup": Status.ASSIGNED_DRIVER_PICKUP,
  "at hub, ready for delivery": Status.AT_HUB_READY_FOR_DELIVERY,
  "captured at warehouse": Status.CAPTURED_AT_WAREHOUSE,
  "dispatched for delivery": Status.DISPATCHED_FOR_DELIVERY,
  "driver accepted pickup": Status.DRIVER_ACCEPTED_PICKUP,
  "driver on route to pickup": Status.DRIVER_ON_ROUTE_TO_PICKUP,
  "driver picked": Status.DRIVER_PICKED,
  "on route to warehouse": Status.ON_ROUTE_TO_WAREHOUSE,
  "package delivered": Status.PACKAGE_DELIVERED,
  "pending": Status.PENDING,
  "route assigned": Status.ROUTE_ASSIGNED
});

class Destination {
  Destination({
    required this.id,
    required this.oldApiId,
    required this.mapCode,
    required this.territory,
    required this.houseNumber,
    required this.streetName,
    required this.physicalAddress,
    required this.latitude,
    required this.longitude,
    required this.nationalPostcode,
  });

  int id;
  dynamic oldApiId;
  String mapCode;
  Territory? territory;
  String houseNumber;
  String streetName;
  String physicalAddress;
  double latitude;
  double longitude;
  String nationalPostcode;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json["id"],
        oldApiId: json["old_api_id"],
        mapCode: json["map_code"],
        territory: territoryValues.map[json["territory"]],
        houseNumber: json["house_number"],
        streetName: json["street_name"],
        physicalAddress: json["physical_address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        nationalPostcode: json["national_postcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "old_api_id": oldApiId,
        "map_code": mapCode,
        "territory": territoryValues.reverse[territory],
        "house_number": houseNumber,
        "street_name": streetName,
        "physical_address": physicalAddress,
        "latitude": latitude,
        "longitude": longitude,
        "national_postcode": nationalPostcode,
      };
}

enum Territory { UGA }

final territoryValues = EnumValues({"UGA": Territory.UGA});

class DriverClass {
  DriverClass({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.rating,
  });

  int id;
  FirstName? firstName;
  String lastName;
  String phoneNumber;
  int rating;

  factory DriverClass.fromJson(Map<String, dynamic> json) => DriverClass(
        id: json["id"],
        firstName: firstNameValues.map[json["first_name"]],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastName,
        "phone_number": phoneNumber,
        "rating": rating,
      };
}

enum FirstName { ANTHONY, FRED, E, FRANCIS }

final firstNameValues = EnumValues({
  "Anthony": FirstName.ANTHONY,
  "E": FirstName.E,
  "Francis": FirstName.FRANCIS,
  "Fred": FirstName.FRED
});

class Size {
  Size({
    required this.id,
    required this.oldApiId,
    required this.name,
    required this.districts,
    required this.description,
  });

  int id;
  dynamic oldApiId;
  String name;
  List<Size>? districts;
  Description? description;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        oldApiId: json["old_api_id"],
        name: json["name"],
        districts: json["districts"] == null
            ? null
            : List<Size>.from(json["districts"].map((x) => Size.fromJson(x))),
        description: json["description"] == null
            ? null
            : descriptionValues.map[json["description"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "old_api_id": oldApiId,
        "name": name,
        "districts": districts == null
            ? null
            : List<dynamic>.from(districts!.map((x) => x.toJson())),
        "description":
            description == null ? null : descriptionValues.reverse[description],
      };
}

enum Description { LESS_THAN_5_KG, BETWEEN_10_TO_50_KG, BETWEEN_5_TO_10_KG }

final descriptionValues = EnumValues({
  "between 10 to 50 kg": Description.BETWEEN_10_TO_50_KG,
  "between 5 to 10 kg": Description.BETWEEN_5_TO_10_KG,
  "less than 5kg": Description.LESS_THAN_5_KG
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
