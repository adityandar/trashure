import 'package:flutter/cupertino.dart';
import 'package:trashure_new/code/change_date.dart';

class ProfileProvider extends ChangeNotifier {
  int _id;

  // ignore: unnecessary_getters_setters
  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int id) {
    _id = id;
  }

  String _name;

  // ignore: unnecessary_getters_setters
  String get name => _name;

  // ignore: unnecessary_getters_setters
  set name(String name) {
    _name = name;
  }

  String _email;

  // ignore: unnecessary_getters_setters
  String get email => _email;

  // ignore: unnecessary_getters_setters
  set email(String email) {
    _email = email;
  }

  // ignore: non_constant_identifier_names
  String _noHP;

  // ignore: unnecessary_getters_setters
  String get noHP => _noHP;

  // ignore: unnecessary_getters_setters
  set noHP(String noHP) {
    _noHP = noHP;
  }

  String _level;

  // ignore: unnecessary_getters_setters
  String getLevel() {
    return _level;
  }

  // ignore: unnecessary_getters_setters
  void setLevel(int level) {
    switch (level) {
      case 0:
        _level = "Trashurer Cadet";
        break;
      case 1:
        _level = "Trashurer Pemula";
        break;
      case 2:
        _level = "Trashurer Pintar";
        break;
      case 3:
        _level = "Trashurer Jagoan";
        break;
      case 4:
        _level = "Trashurer Sejati";
        break;
      default:
        break;
    }
  }

  int _balance;

  // ignore: unnecessary_getters_setters
  int get balance => _balance;

  // ignore: unnecessary_getters_setters
  set balance(int balance) {
    _balance = balance;
  }

  int _total;

  // ignore: unnecessary_getters_setters
  int get total => _total;

  // ignore: unnecessary_getters_setters
  set total(int total) {
    _total = total;
  }

  String _ttl = "0";

  String get ttl => _ttl;

  void setTTL(int ttl) {
    _ttl = changeDate(ttl);
  }

  String _avatar;

  // ignore: unnecessary_getters_setters
  String get avatar => _avatar;

  // ignore: unnecessary_getters_setters
  set avatar(String avatar) {
    _avatar = avatar;
  }

  // ignore: avoid_init_to_null
  String _connectedTrashbag = null;

  // ignore: unnecessary_getters_setters
  String get connectedTrashbag => _connectedTrashbag;

  // ignore: unnecessary_getters_setters
  set connectedTrashbag(String connectedTrashbag) {
    _connectedTrashbag = connectedTrashbag;
  }

  void printAll() {
    print(id);
  }

  void logOut() {
    _id = -1;
  }

  void reload() {
    notifyListeners();
  }
}
