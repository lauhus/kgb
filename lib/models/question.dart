import 'dart:core';
import '../enum/enum.dart';

class Question{
  int id = 0;
  String content = "";
  String rightAnswer = "";
  List<String> propositions = [];
  bool active = true;
  LEVELS level = LEVELS.Facile;
  CATEGORIES category = CATEGORIES.Animaux;
  String? image = "";
  bool response = false;

  Question(this.id , this.content , this.rightAnswer , this.propositions , this.active , this.level , this.category ,[this.image , this.response = false]);

  setActive(bool bool) {
    active = bool;
  }
}