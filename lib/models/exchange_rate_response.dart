import 'dart:convert';

class ExchangeRateResponse {
  String? id;
  double? rate;
  DateTime? createdAt;

  ExchangeRateResponse({
    this.id,
    this.rate,
    this.createdAt,
  });

  factory ExchangeRateResponse.fromJson(String str) =>
      ExchangeRateResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeRateResponse.fromMap(Map<String, dynamic> json) =>
      ExchangeRateResponse(
        id: json["id"],
        rate: json["rate"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rate": rate,
        "createdAt": createdAt?.toIso8601String(),
      };
}
