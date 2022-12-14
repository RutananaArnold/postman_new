// To parse this JSON data, do
//
//     final verificationResponse = verificationResponseFromJson(jsonString);

import 'dart:convert';

VerificationResponse verificationResponseFromJson(String str) =>
    VerificationResponse.fromJson(json.decode(str));

String verificationResponseToJson(VerificationResponse data) =>
    json.encode(data.toJson());

class VerificationResponse {
  VerificationResponse({
    required this.token,
    required this.user,
    required this.customer,
  });

  final String token;
  final User user;
  final VerificationResponseCustomer customer;

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      VerificationResponse(
        token: json["token"],
        user: User.fromJson(json["user"]),
        customer: VerificationResponseCustomer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
        "customer": customer.toJson(),
      };
}

class VerificationResponseCustomer {
  VerificationResponseCustomer({
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

  final int id;
  final DateTime createdAt;
  final dynamic createdBy;
  final dynamic oldApiId;
  final dynamic firstName;
  final dynamic lastName;
  final String phoneNumber;
  final dynamic email;
  final bool active;
  final int accumulatedPoints;
  final int user;
  final List<dynamic> addresses;
  final bool isBusiness;
  final dynamic businessName;
  final dynamic positionInBusiness;
  final dynamic createdById;
  final int userId;

  factory VerificationResponseCustomer.fromJson(Map<String, dynamic> json) =>
      VerificationResponseCustomer(
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
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
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

class User {
  User({
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

  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final Profile profile;
  final UserCustomer customer;
  final dynamic driver;
  final bool isStaff;
  final DateTime dateJoined;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profile: Profile.fromJson(json["profile"]),
        customer: UserCustomer.fromJson(json["customer"]),
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

class UserCustomer {
  UserCustomer({
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

  final int id;
  final dynamic firstName;
  final dynamic lastName;
  final String phoneNumber;
  final dynamic email;
  final bool active;
  final int accumulatedPoints;
  final List<dynamic> addresses;
  final bool isBusiness;
  final dynamic businessName;
  final dynamic positionInBusiness;

  factory UserCustomer.fromJson(Map<String, dynamic> json) => UserCustomer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        active: json["active"],
        accumulatedPoints: json["accumulated_points"],
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
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
        "addresses": List<dynamic>.from(addresses.map((x) => x)),
        "is_business": isBusiness,
        "business_name": businessName,
        "position_in_business": positionInBusiness,
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

  final int id;
  final dynamic phone;
  final Role role;
  final dynamic image;
  final dynamic dob;
  final dynamic gender;
  final bool profileSetupCompleted;

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

  final int id;
  final String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
