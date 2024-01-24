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
        "imageUrl": imageUrl,
        "videoUrl": videoUrl,
      };
}
