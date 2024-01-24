import 'dart:convert';

class MusicianResponse {
  int? totalCount;
  List<Content>? result;

  MusicianResponse({
    this.totalCount,
    this.result,
  });

  factory MusicianResponse.fromJson(String str) =>
      MusicianResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MusicianResponse.fromMap(Map<String, dynamic> json) =>
      MusicianResponse(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? []
            : List<Content>.from(
                json["result"]!.map((x) => Content.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class Content {
  String? id;
  String? name;
  String? lastname;
  String? email;
  DateTime? birthdate;
  DateTime? startDate;
  String? description;
  bool? isHighlighted;
  String? gender;
  String? fullname;
  String? imageUrl;

  Content({
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.birthdate,
    this.startDate,
    this.description,
    this.isHighlighted,
    this.gender,
    this.fullname,
    this.imageUrl,
  });

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        description: json["description"],
        isHighlighted: json["isHighlighted"],
        gender: json["gender"],
        fullname: json["fullname"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "isHighlighted": isHighlighted,
        "gender": gender,
        "fullname": fullname,
        "imageUrl": imageUrl,
      };
}
