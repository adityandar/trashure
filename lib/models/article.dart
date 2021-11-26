import 'dart:convert';

class Article {
  int id;
  // ignore: non_constant_identifier_names
  String title;
  String image;
  String description;
  int date;

  Article({this.id, this.description, this.image, this.title, this.date});

  factory Article.fromJson(Map<String, dynamic> map) {
    return Article(
        id: map["id"],
        title: map["title"],
        image: map["image"],
        description: map["description"],
        date: map["date"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "image": image,
      "description": description,
      "date": date
    };
  }

  @override
  String toString() {
    return 'Article{id: $id, title: $title, image: $image, description: $description, date: $date}';
  }
}

List<Article> articlesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Article>.from(data.map((item) => Article.fromJson(item)));
}

Article articleFromJson(String jsonData) {
  final data = json.decode(jsonData);
  print(data[0]);
  return Article.fromJson(data[0]);
}

String articleToJson(Article data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
