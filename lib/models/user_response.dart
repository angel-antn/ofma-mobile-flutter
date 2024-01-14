import 'dart:convert';

class UserResponse {
  User user;
  String? token;

  UserResponse({
    required this.user,
    required this.token,
  });

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        user: User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "token": token,
      };
}

class User {
  String? id;
  String? email;
  String? name;
  String? lastname;
  bool? isCollaborator;
  bool? isPremium;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.lastname,
    required this.isCollaborator,
    required this.isPremium,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        isCollaborator: json["isCollaborator"],
        isPremium: json["isPremium"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "isCollaborator": isCollaborator,
        "isPremium": isPremium
      };
}
