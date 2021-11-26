import 'dart:convert';

class History {
  int id;
  // ignore: non_constant_identifier_names
  String id_trashbag;
  int date;
  int status;

  History({
    this.id,
    // ignore: non_constant_identifier_names
    this.id_trashbag,
    this.date,
    this.status,
  });

  factory History.fromJson(Map<String, dynamic> map) {
    return History(
      id: map["id"],
      id_trashbag: map["id_trashbag"],
      date: map["date"],
      status: map["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "id_trashbag": id_trashbag,
      "date": date,
      "status": status,
    };
  }

  @override
  String toString() {
    return 'History{id: $id, id_trashbag: $id_trashbag, date: $date, status: $status}';
  }
}

List<History> historiesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<History>.from(data.map((item) => History.fromJson(item)));
}

History historyFromJson(String jsonData) {
  final data = json.decode(jsonData);
  print(data[0]);
  return History.fromJson(data[0]);
}

String historyToJson(History data) {
  final jsonData = data.toJson();
  print(jsonData);
  return json.encode(jsonData);
}
