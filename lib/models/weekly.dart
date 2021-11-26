import 'dart:convert';

class Weekly {
  int satu;
  int dua;
  int tiga;
  int empat;

  Weekly({this.satu, this.dua, this.tiga, this.empat});

  factory Weekly.fromJson(List<dynamic> map) {
    return Weekly(
      satu: map[1],
      dua: map[2],
      tiga: map[3],
      empat: map[4],
    );
  }
}

List<Weekly> weekliesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Weekly>.from(data.map((item) => Weekly.fromJson(item)));
}

Weekly weeklyFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return Weekly.fromJson(data);
}
