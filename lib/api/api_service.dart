import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/models/article.dart';
import 'package:trashure_new/models/history.dart';
import 'package:trashure_new/models/profile.dart';
import 'package:trashure_new/models/weekly.dart';

class ApiService {
  Client client = Client();

  Future<List<Profile>> getProfiles() async {
    final response = await client.get("$baseUrl/read_profiles.php");
    if (response.statusCode == 200) {
      return profilesFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createProfile(Profile data) async {
    final response = await client.post(
      "$baseUrl/register.php",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> register(Profile data) async {
    var name = data.name;
    var email = data.email;
    // ignore: non_constant_identifier_names
    var no_hp = data.no_hp;
    var password = data.password;
    final response = await client.get(
        "$baseUrl/register.php?name=$name&email=$email&password=$password&no_hp=$no_hp");
    if (response.statusCode == 201) {
      return int.tryParse(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<int> login(String email, String password) async {
    final response =
        await client.get("$baseUrl/login.php?email=$email&password=$password");
    if (response.statusCode == 200) {
      print(response.body);
      // return jsonDecode(response.body);
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<Profile> getProfile(int id) async {
    final response = await client.get("$baseUrl/read_profile.php?id=$id");
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<History>> getHistories(int id) async {
    final response = await client.get("$baseUrl/read_histories.php?id=$id");
    if (response.statusCode == 200) {
      return historiesFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> connectTrashbag(String idTrashbag) async {
    final response = await client
        .get("$baseUrl/connect_trashbag.php?id_trashbag=$idTrashbag");
    if (response.statusCode == 200) {
      int temp = jsonDecode(response.body);
      if (temp == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<int> update(Profile data) async {
    var id = data.id;
    var name = data.name;
    var email = data.email;
    // ignore: non_constant_identifier_names
    var no_hp = data.no_hp;
    var ttl = data.ttl;
    final response = await client.get(
        "$baseUrl/update_profile.php?id=$id&name=$name&email=$email&no_hp=$no_hp&ttl=$ttl");
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<int> pulsa(int id, int balance) async {
    final response =
        await client.get("$baseUrl/pulsa.php?id=$id&balance=$balance");
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<List<Article>> getArticles() async {
    final response = await client.get("$baseUrl/read_articles.php");
    if (response.statusCode == 200) {
      return articlesFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Weekly> getWeekly(int id) async {
    final response = await client.get("$baseUrl/trashbag_weekly.php?id=$id");
    if (response.statusCode == 200) {
      return weeklyFromJson(response.body);
    } else {
      return null;
    }
  }
}
