class AddressCodeResponse {
  AddressCodeResponse({
    // required this.total,
    // required this.perPage,
    // required this.currentPage,
    // required this.lastPage,
    // required this.next,
    // required this.previous,
    required this.results,
  });

  // final int total;
  // final int perPage;
  // final int currentPage;
  // final int lastPage;
  // final String next;
  // final dynamic previous;
  final List<Result> results;

  factory AddressCodeResponse.fromJson(Map<String, dynamic> json) =>
      AddressCodeResponse(
        // total: json["total"],
        // perPage: json['perPage'],
        // currentPage: json["current_page"],
        // lastPage: json["last_page"],
        // next: json["next"],
        // previous: json["previous"],
        results:  List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
      );
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

  final int id;
  final DateTime createdAt;
  final CreatedBy createdBy;
  final dynamic oldApiId;
  final String mapCode;
  final String territory;
  final Parish parish;
  final String houseNumber;
  final String streetName;
  final String physicalAddress;
  final double latitude;
  final double longitude;
  final int createdById;
  final int parishId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: CreatedBy.fromJson(json["created_by"]),
        oldApiId: json["old_api_id"],
        mapCode: json["map_code"],
        territory: json["territory"],
        parish: Parish.fromJson(json["parish"]),
        houseNumber: json["house_number"],
        streetName: json["street_name"],
        physicalAddress: json["physical_address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        createdById: json["created_by_id"],
        parishId: json["parish_id"],
      );
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.username,
    required this.getFullName,
  });

  final int id;
  final String username;
  final String getFullName;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        username: json["username"],
        getFullName: json["get_full_name"],
      );
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

  final int id;
  final dynamic oldApiId;
  final String postCode;
  final String name;
  final String districtName;
  final String countyName;
  final String subCountyName;

  factory Parish.fromJson(Map<String, dynamic> json) => Parish(
        id: json["id"],
        oldApiId: json["old_api_id"],
        postCode: json["post_code"],
        name: json["name"],
        districtName: json["district_name"],
        countyName: json["county_name"],
        subCountyName: json["sub_county_name"],
      );
}
