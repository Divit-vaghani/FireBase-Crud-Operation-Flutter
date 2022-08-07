import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.isVerified,
    required this.mobileNo,
    required this.photoUrl,
  });

  final String name;
  final String email;
  final String isVerified;
  final String mobileNo;
  final String photoUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        isVerified: json["isVerified"],
        mobileNo: json["mobileNo"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "isVerified": isVerified,
        "mobileNo": mobileNo,
        "photoUrl": photoUrl,
      };
}
