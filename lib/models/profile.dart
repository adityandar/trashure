import 'dart:convert';

class Profile {
  int id;
  String name;
  String email;
  String password;
  // ignore: non_constant_identifier_names
  String no_hp;
  int level;
  int balance;
  int total;
  int ttl;
  String avatar;

  Profile({
    this.id,
    this.name,
    this.email,
    this.password,
    // ignore: non_constant_identifier_names
    this.no_hp,
    this.level,
    this.balance,
    this.total,
    this.ttl,
    this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      password: map["password"],
      no_hp: map["no_hp"],
      level: map["level"],
      balance: map["balance"],
      total: map["total"],
      ttl: map["ttl"],
      avatar: map["avatar"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "no_hp": no_hp,
      "level": level,
      "balance": balance,
      "total": total,
      "ttl": ttl,
      "avatar": avatar,
    };
  }

  @override
  String toString() {
    return 'Profile{name: $name, email: $email, password: $password, no_hp: $no_hp, level: $level,  balance: $balance,  total: $total, ttl: $ttl, avatar: $avatar}';
  }
}

List<Profile> profilesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

Profile profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  print(data[0]);
  return Profile.fromJson(data[0]);
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  print(jsonData);
  return json.encode(jsonData);
}
