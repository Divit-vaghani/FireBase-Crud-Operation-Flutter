import 'dart:convert';

List<UserInformation> userInformationFromJson(String str) =>
    List<UserInformation>.from(
        json.decode(str).map((x) => UserInformation.fromJson(x)));

String userInformationToJson(List<UserInformation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserInformation {
  UserInformation({
    required this.lastname,
    required this.name,
    required this.roll,
  });

  final String lastname;
  final String name;
  final String roll;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
        lastname: json["lastname"],
        name: json["name"],
        roll: json["roll"],
      );

  Map<String, dynamic> toJson() => {
        "lastname": lastname,
        "name": name,
        "roll": roll,
      };
}
