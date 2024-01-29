import 'dart:convert';

import 'package:ofma_app/models/concert_response.dart';

class UseTicketResponse {
  String? id;
  bool? isUsed;
  Concert? concert;

  UseTicketResponse({
    this.id,
    this.isUsed,
    this.concert,
  });

  factory UseTicketResponse.fromJson(String str) =>
      UseTicketResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UseTicketResponse.fromMap(Map<String, dynamic> json) =>
      UseTicketResponse(
        id: json["id"],
        isUsed: json["isUsed"],
        concert:
            json["concert"] == null ? null : Concert.fromMap(json["concert"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "isUsed": isUsed,
        "concert": concert?.toMap(),
      };
}
