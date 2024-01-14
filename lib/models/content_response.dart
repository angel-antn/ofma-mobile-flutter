import 'dart:convert';

class ContentResponse {
  int? totalCount;
  List<Content>? result;

  ContentResponse({
    this.totalCount,
    this.result,
  });

  factory ContentResponse.fromRawJson(String str) =>
      ContentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      ContentResponse(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? []
            : List<Content>.from(
                json["result"]!.map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
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

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
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

  Map<String, dynamic> toJson() => {
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
