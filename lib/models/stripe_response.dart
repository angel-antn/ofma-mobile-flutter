import 'dart:convert';

class StripeResponse {
  String? clientSecret;
  String? customerId;
  String? paymentIntentId;

  StripeResponse({
    this.clientSecret,
    this.customerId,
    this.paymentIntentId,
  });

  factory StripeResponse.fromJson(String str) =>
      StripeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StripeResponse.fromMap(Map<String, dynamic> json) => StripeResponse(
        clientSecret: json["clientSecret"],
        customerId: json["customerId"],
        paymentIntentId: json["paymentIntentId"],
      );

  Map<String, dynamic> toMap() => {
        "clientSecret": clientSecret,
        "customerId": customerId,
        "paymentIntentId": paymentIntentId,
      };
}
