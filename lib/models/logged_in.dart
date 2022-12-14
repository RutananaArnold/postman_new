// To parse this JSON data, do
//
//     final loggedInUser = loggedInUserFromJson(jsonString);

import 'dart:convert';

LoggedInUser loggedInUserFromJson(String str) => LoggedInUser.fromJson(json.decode(str));

String loggedInUserToJson(LoggedInUser data) => json.encode(data.toJson());

class LoggedInUser {
    LoggedInUser({
        required this.id,
        required this.phone,
    });

    final String id;
    final String phone;

    factory LoggedInUser.fromJson(Map<String, dynamic> json) => LoggedInUser(
        id: json["id"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
    };
}
