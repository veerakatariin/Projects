class UserData {
  final int id;
  final String name;
  final String email;
  final String registrationDate;
  final List events;
  final List interests;

  const UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.registrationDate,
      required this.events,
      required this.interests});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        registrationDate: json['registrationDate'],
        events: json['events'],
        interests: json['interests']);
  }
}

class MyUserData {
  final int id;
  final String name;
  final String email;
  final String registrationDate;
  final List events;
  final List interests;
  final String profileImg;

  const MyUserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.registrationDate,
      required this.events,
      required this.interests,
      required this.profileImg});

  factory MyUserData.fromJson(Map<String, dynamic> json) {
    return MyUserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        registrationDate: json['registrationDate'],
        events: json['events'],
        interests: json['interests'],
        profileImg: json["img"]);
  }
}
