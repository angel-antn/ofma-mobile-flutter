import 'dart:convert';

class ConcertResponse {
  int? totalCount;
  List<Concert>? result;

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
            : List<Concert>.from(
                json["result"]!.map((x) => Concert.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Concert {
  String? id;
  String? name;
  DateTime? startDate;
  String? startAtHour;
  bool? isOpen;
  bool? hasFinish;
  String? description;
  String? address;
  int? entriesQty;
  double? pricePerEntry;
  List<ConcertMusician>? concertMusician;
  String? imageUrl;

  Concert({
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
    this.concertMusician,
    this.imageUrl,
  });

  factory Concert.fromJson(String str) => Concert.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Concert.fromMap(Map<String, dynamic> json) => Concert(
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
        pricePerEntry: json["pricePerEntry"]?.toDouble(),
        concertMusician: json["concertMusician"] == null
            ? []
            : List<ConcertMusician>.from(json["concertMusician"]!
                .map((x) => ConcertMusician.fromMap(x))),
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
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
        "concertMusician": concertMusician == null
            ? []
            : List<dynamic>.from(concertMusician!.map((x) => x.toMap())),
        "imageUrl": imageUrl,
      };
}

class ConcertMusician {
  String? id;
  String? musicianId;
  String? role;
  String? name;
  String? lastname;
  String? fullname;
  String? imageUrl;

  ConcertMusician({
    this.id,
    this.musicianId,
    this.role,
    this.name,
    this.lastname,
    this.fullname,
    this.imageUrl,
  });

  factory ConcertMusician.fromJson(String str) =>
      ConcertMusician.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConcertMusician.fromMap(Map<String, dynamic> json) => ConcertMusician(
        id: json["id"],
        musicianId: json["musicianId"],
        role: json["role"],
        name: json["name"],
        lastname: json["lastname"],
        fullname: json["fullname"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "musicianId": musicianId,
        "role": role,
        "name": name,
        "lastname": lastname,
        "fullname": fullname,
        "imageUrl": imageUrl,
      };
}
