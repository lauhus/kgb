import 'dart:core';

class Question{
  int id = 0;
  String content = "";
  String rightAnswer = "";
  List<String> propositions = [];
  bool active = true;
  String? image = "";
  bool response = false;

  Question(this.id , this.content , this.rightAnswer , this.propositions , this.active ,[this.image , this.response = false]);

  setActive(bool bool) {
    active = bool;
  }
}