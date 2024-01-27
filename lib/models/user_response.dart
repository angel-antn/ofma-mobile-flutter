import 'dart:convert';

class UserResponse {
  User? user;
  String? token;

  UserResponse({
    this.user,
    this.token,
  });

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
        "token": token,
      };
}

class User {
  String? id;
  String? email;
  String? name;
  String? lastname;
  bool? isCollaborator;
  DateTime? premiumUntil;
  bool? isPremium;

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.isCollaborator,
    this.premiumUntil,
    this.isPremium,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        isCollaborator: json["isCollaborator"],
        premiumUntil: json["premiumUntil"] == null
            ? null
            : DateTime.parse(json["premiumUntil"]),
        isPremium: json["isPremium"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "isCollaborator": isCollaborator,
        "premiumUntil": premiumUntil == null
            ? null
            : "${premiumUntil!.year.toString().padLeft(4, '0')}-${premiumUntil!.month.toString().padLeft(2, '0')}-${premiumUntil!.day.toString().padLeft(2, '0')}",
        "isPremium": isPremium,
      };
}
