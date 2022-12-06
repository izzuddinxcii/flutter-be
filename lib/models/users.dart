import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

List<User> usersFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String usersToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.skillSets,
    required this.hobby,
    required this.enable,
    required this.createdAt,
  });

  String id;
  String username;
  String email;
  String phoneNumber;
  List<dynamic> skillSets;
  List<dynamic> hobby;
  bool enable;
  String createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        skillSets: List<dynamic>.from(json["skillSets"].map((x) => x)),
        hobby: List<dynamic>.from(json["hobby"].map((x) => x)),
        enable: json["enable"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
        "skillSets": List<dynamic>.from(skillSets.map((x) => x)),
        "hobby": List<dynamic>.from(hobby.map((x) => x)),
        "enable": enable,
        "createdAt": createdAt,
      };
}
