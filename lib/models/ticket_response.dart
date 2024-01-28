import 'dart:convert';

class TicketResponse {
  int? totalCount;
  List<Ticket>? result;

  TicketResponse({
    this.totalCount,
    this.result,
  });

  factory TicketResponse.fromJson(String str) =>
      TicketResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketResponse.fromMap(Map<String, dynamic> json) => TicketResponse(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? []
            : List<Ticket>.from(json["result"]!.map((x) => Ticket.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class Ticket {
  Concert? concert;
  String? id;
  bool? isUsed;

  Ticket({
    this.concert,
    this.id,
    this.isUsed,
  });

  factory Ticket.fromJson(String str) => Ticket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        concert:
            json["concert"] == null ? null : Concert.fromMap(json["concert"]),
        id: json["id"],
        isUsed: json["isUsed"],
      );

  Map<String, dynamic> toMap() => {
        "concert": concert?.toMap(),
        "id": id,
        "isUsed": isUsed,
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
  int? pricePerEntry;
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
        pricePerEntry: json["pricePerEntry"],
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
        "imageUrl": imageUrl,
      };
}
