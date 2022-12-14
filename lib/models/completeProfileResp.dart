// To parse this JSON data, do
//
//     final completeProfileResp = completeProfileRespFromJson(jsonString);

import 'dart:convert';

CompleteProfileResp completeProfileRespFromJson(String str) =>
    CompleteProfileResp.fromJson(json.decode(str));

String completeProfileRespToJson(CompleteProfileResp data) =>
    json.encode(data.toJson());

class CompleteProfileResp {
  CompleteProfileResp({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.active,
    required this.image,
    required this.gender,
    required this.dob,
    required this.isBusiness,
    required this.businessName,
    required this.positionInBusiness,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final bool active;
  final String image;
  final String gender;
  final String dob;
  final bool isBusiness;
  final String businessName;
  final String positionInBusiness;

  factory CompleteProfileResp.fromJson(Map<String, dynamic> json) =>
      CompleteProfileResp(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        active: json["active"],
        image: json["image"],
        gender: json["gender"],
        dob: json["dob"],
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
        "image": image,
        "gender": gender,
        "dob": dob,
        "is_business": isBusiness,
        "business_name": businessName,
        "position_in_business": positionInBusiness,
      };
}
