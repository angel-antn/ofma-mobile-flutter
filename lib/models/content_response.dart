import 'dart:convert';

class ContentResponse {
  int? totalCount;
  List<Content>? result;

  ContentResponse({
    this.totalCount,
    this.result,
  });

  factory ContentResponse.fromJson(String str) =>
      ContentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentResponse.fromMap(Map<String, dynamic> json) => ContentResponse(
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
  String? description;
  String? category;
  bool? isHighlighted;
  bool? isShown;
  bool? isDraft;
  List<ExclusiveContentMusician>? exclusiveContentMusician;
  String? imageUrl;
  String? videoUrl;

  Content({
    this.id,
    this.name,
    this.description,
    this.category,
    this.isHighlighted,
    this.isShown,
    this.isDraft,
    this.exclusiveContentMusician,
    this.imageUrl,
    this.videoUrl,
  });

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        isHighlighted: json["isHighlighted"],
        isShown: json["isShown"],
        isDraft: json["isDraft"],
        exclusiveContentMusician: json["exclusiveContentMusician"] == null
            ? []
            : List<ExclusiveContentMusician>.from(
                json["exclusiveContentMusician"]!
                    .map((x) => ExclusiveContentMusician.fromMap(x))),
        imageUrl: json["imageUrl"],
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category,
        "isHighlighted": isHighlighted,
        "isShown": isShown,
        "isDraft": isDraft,
        "exclusiveContentMusician": exclusiveContentMusician == null
            ? []
            : List<dynamic>.from(
                exclusiveContentMusician!.map((x) => x.toMap())),
        "imageUrl": imageUrl,
        "videoUrl": videoUrl,
      };
}

class ExclusiveContentMusician {
  String? id;
  String? musicianId;
  String? role;
  String? name;
  String? lastname;
  String? fullname;
  String? imageUrl;

  ExclusiveContentMusician({
    this.id,
    this.musicianId,
    this.role,
    this.name,
    this.lastname,
    this.fullname,
    this.imageUrl,
  });

  factory ExclusiveContentMusician.fromJson(String str) =>
      ExclusiveContentMusician.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExclusiveContentMusician.fromMap(Map<String, dynamic> json) =>
      ExclusiveContentMusician(
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
