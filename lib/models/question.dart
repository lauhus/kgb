class Question{
  int id = 0;
  String content = "";
  String rightAnswer = "";
  List<String> propositions = [];
  bool active = true;
  String? image = "";

  Question(this.id , this.content , this.rightAnswer , this.propositions , this.active ,[this.image]);

  setActive(bool bool) {
    active = bool;
  }
}