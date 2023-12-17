import 'dart:convert';

class ConcertResponse {
  int? totalCount;
  List<Result>? result;

  ConcertResponse({
    this.totalCount,
    this.result,
  });

  factory ConcertResponse.fromJson(String str) =>
      ConcertResponse.fromMap(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConcertResponse.fromMap(Map<String, dynamic> json) => ConcertResponse(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  String? id;
  String? name;
  DateTime? startDate;
  String? startAtHour;
  bool? isOpen;
  bool? hasFinish;
  String? description;
  String? address;
  int? entriesQty;
  int? pricePerEntry;
  String? imageUrl;

  Result({
    this.id,
    this.name,
    this.startDate,
    this.startAtHour,
    this.isOpen,
    this.hasFinish,
    this.description,
    this.address,
    this.entriesQty,
    this.pricePerEntry,
    this.imageUrl,
  });

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        startAtHour: json["startAtHour"],
        isOpen: json["isOpen"],
        hasFinish: json["hasFinish"],
        description: json["description"],
        address: json["address"],
        entriesQty: json["entriesQty"],
        pricePerEntry: json["pricePerEntry"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "startAtHour": startAtHour,
        "isOpen": isOpen,
        "hasFinish": hasFinish,
        "description": description,
        "address": address,
        "entriesQty": entriesQty,
        "pricePerEntry": pricePerEntry,
        "imageUrl": imageUrl,
      };
}
