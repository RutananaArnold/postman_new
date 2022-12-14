// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.token,
    this.user,
    this.customer,
  });

  String? token;
  UserClass? user;
  UserCustomer? customer;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        user: UserClass.fromJson(json["user"]),
        customer: UserCustomer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
        "customer": customer!.toJson(),
      };
}

class UserCustomer {
  UserCustomer({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.oldApiId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.active,
    required this.accumulatedPoints,
    required this.user,
    required this.addresses,
    required this.isBusiness,
    required this.businessName,
    required this.positionInBusiness,
    required this.createdById,
    required this.userId,
  });

  int id;
  DateTime createdAt;
  dynamic createdBy;
  dynamic oldApiId;
  dynamic firstName;
  dynamic lastName;
  String phoneNumber;
  dynamic email;
  bool active;
  int accumulatedPoints;
  int user;
  List<int> addresses;
  bool isBusiness;
  dynamic businessName;
  dynamic positionInBusiness;
  dynamic createdById;
  int userId;

  factory UserCustomer.fromJson(Map<String, dynamic> json) => UserCustomer(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        oldApiId: json["old_api_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        active: json["active"],
        accumulatedPoints: json["accumulated_points"],
        user: json["user"],
        addresses: List<int>.from(json["addresses"].map((x) => x)),
        isBusiness: json["is_business"],
        businessName: json["business_name"],
        positionInBusiness: json["position_in_business"],
        createdById: json["created_by_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "old_api_id": oldApiId,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "email": email,
        "active": active,
        "accumulated_points": accumulatedPoints,
        "user": user,
        "addresses": List<dynamic>.from(addresses.map((x) => x)),
        "is_business": isBusiness,
        "business_name": businessName,
        "position_in_business": positionInBusiness,
        "created_by_id": createdById,
        "user_id": userId,
      };
}

class UserClass {
  UserClass({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profile,
    required this.customer,
    required this.driver,
    required this.isStaff,
    required this.dateJoined,
  });

  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  Profile profile;
  UserCustomerClass customer;
  dynamic driver;
  bool isStaff;
  DateTime dateJoined;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profile: Profile.fromJson(json["profile"]),
        customer: UserCustomerClass.fromJson(json["customer"]),
        driver: json["driver"],
        isStaff: json["is_staff"],
        dateJoined: DateTime.parse(json["date_joined"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profile": profile.toJson(),
        "customer": customer.toJson(),
        "driver": driver,
        "is_staff": isStaff,
        "date_joined": dateJoined.toIso8601String(),
      };
}

class UserCustomerClass {
  UserCustomerClass({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.active,
    required this.accumulatedPoints,
    required this.addresses,
    required this.isBusiness,
    required this.businessName,
    required this.positionInBusiness,
  });

  int id;
  dynamic firstName;
  dynamic lastName;
  String phoneNumber;
  dynamic email;
  bool active;
  int accumulatedPoints;
  List<Address> addresses;
  bool isBusiness;
  dynamic businessName;
  dynamic positionInBusiness;

  factory UserCustomerClass.fromJson(Map<String, dynamic> json) =>
      UserCustomerClass(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        active: json["active"],
        accumulatedPoints: json["accumulated_points"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        isBusiness: json["is_business"],
        businessName: json["business_name"],
        positionInBusiness: json["position_in_business"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "email": email,
        "active": active,
        "accumulated_points": accumulatedPoints,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "is_business": isBusiness,
        "business_name": businessName,
        "position_in_business": positionInBusiness,
      };
}

class Address {
  Address({
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
  });

  int id;
  DateTime createdAt;
  int createdBy;
  dynamic oldApiId;
  String mapCode;
  String territory;
  Parish parish;
  String houseNumber;
  String streetName;
  String physicalAddress;
  double latitude;
  double longitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        oldApiId: json["old_api_id"],
        mapCode: json["map_code"],
        territory: json["territory"],
        parish: Parish.fromJson(json["parish"]),
        houseNumber: json["house_number"],
        streetName: json["street_name"],
        physicalAddress: json["physical_address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "old_api_id": oldApiId,
        "map_code": mapCode,
        "territory": territory,
        "parish": parish.toJson(),
        "house_number": houseNumber,
        "street_name": streetName,
        "physical_address": physicalAddress,
        "latitude": latitude,
        "longitude": longitude,
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
        postCode: json["post_code"],
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

class Profile {
  Profile({
    required this.id,
    required this.phone,
    required this.role,
    required this.image,
    required this.dob,
    required this.gender,
    required this.profileSetupCompleted,
  });

  int id;
  dynamic phone;
  Role role;
  dynamic image;
  dynamic dob;
  dynamic gender;
  bool profileSetupCompleted;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        phone: json["phone"],
        role: Role.fromJson(json["role"]),
        image: json["image"],
        dob: json["dob"],
        gender: json["gender"],
        profileSetupCompleted: json["profile_setup_completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "role": role.toJson(),
        "image": image,
        "dob": dob,
        "gender": gender,
        "profile_setup_completed": profileSetupCompleted,
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
