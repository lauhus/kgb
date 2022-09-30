import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kgb/enum/enum.dart';
import 'dart:developer';
import './models/question.dart';

void main() {
  runApp(const KgbApp());
}

class KgbApp extends StatelessWidget {
  const KgbApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Oswald",
          primarySwatch: Colors.deepPurple,
      ),
      routes: {
        '/': (context) => const QuestionsPage(),
      },
        initialRoute: '/',
    );
  }
}

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> questionsList = [];
  late int result =  0;

  LEVELS selectedLevel = LEVELS.Niveau;
  CATEGORIES selectedCategory = CATEGORIES.Categories;


  setListInit() {
    setState(() {
      Question question1 = Question(0, "Le ciel est-il bleu?" , "oui", [ "oui" , "non" ] , true , LEVELS.Facile , CATEGORIES.Autre);
      Question question2 = Question(1, "L'herbe est-elle verte?" , "oui", [ "oui" , "non" ] , true , LEVELS.Facile , CATEGORIES.Autre);
      Question question3 = Question(2, "Les chats font-ils miaou ?" , "oui", [ "oui" , "non" ], true , LEVELS.Facile , CATEGORIES.Animaux);
      Question question4 = Question(3, "Les chiens font-ils ouafs?" , "oui", [ "oui" , "non" , "bob" ] , true , LEVELS.Facile , CATEGORIES.Animaux);
      Question question5 = Question(4, "Quel jours somme-nous?" , "30", [], true , LEVELS.Facile , CATEGORIES.Autre);
      Question question6 = Question(5, "Quel est ce personnage ?" , "Harry potter" , [] , true , LEVELS.Facile , CATEGORIES.Film , "https://media-mcetv.ouest-france.fr/wp-content/uploads/2022/09/harry-potter-top-10-des-fois-ou-les-mechants-ont-ete-justes-.jpeg");

      Question question7 = Question(6, "Quelle est la meilleure librairie front-end?" , "Reactjs", [ "ReactJs" , "VueJs" ] , true , LEVELS.Medium , CATEGORIES.Technologie);
      Question question8 = Question(7, "Qui est gossip girl ?" , "Dan", [ "Dan" , "Serena" ] , true , LEVELS.Medium , CATEGORIES.Serie);
      Question question9 = Question(8, "Comment s'appelle le batard de Ned Stark ?" , "John snow", [ "Ramsey Snow" , "John Snow" ], true , LEVELS.Medium , CATEGORIES.Serie);
      Question question10 = Question(9, "Quel est l'ingrédient principal du Risotto ?" , "Riz", [ "Pomme de terre" , "Riz" , "Semoule" ] , true , LEVELS.Medium , CATEGORIES.Alimentation);
      Question question11 = Question(10, "En qu'elle années somme nous ?" , "2022", [], true , LEVELS.Medium , CATEGORIES.Autre);
      Question question12 = Question(11, "Qui est cet homme ?" , "Tom cruise", [] , true , LEVELS.Medium , CATEGORIES.Film , "https://www.gala.fr/imgre/fit/~1~gal~2022~05~31~ca422337-0e1e-4061-83c9-459fa7a4aa99.jpeg/100x100/quality/80/focus-point/1415%2C954/tom-cruise.jpg");

      Question question13 = Question(12, "Qu'elle est ma date de naissance ?" , "27 juillet 1995", [ "27 juillet 1995" , "12 Avril 1999" ] , true , LEVELS.Difficile , CATEGORIES.Autre);
      Question question14 = Question(13, "Comment s'appelle mon chat ?" , "Rocky", [ "Pierre" , "Rocky" ] , true , LEVELS.Difficile , CATEGORIES.Animaux);
      Question question15 = Question(14, "Quel est le modèle de ma voiture ?" , "DS3", [ "Serie 1" , "Class A" , "DS3" ], true , LEVELS.Difficile , CATEGORIES.Autre);
      Question question16 = Question(15, "Quel est le meilleur plat ?" , "Raclette", [ "Tartiflette" , "Fondue" , "Raclette" ] , true , LEVELS.Difficile , CATEGORIES.Alimentation);
      Question question17 = Question(16, "Le meilleur Film de tout les temps ?" , "Gatsby le Magnifique", ["Gatsby le Magnifique" , "Inception" , "Bienvenue chez les chtis"], true , LEVELS.Difficile , CATEGORIES.Autre);
      Question question18 = Question(17, "Qui est cet homme ?" , "Ryan Gosling", [] , true , LEVELS.Difficile , CATEGORIES.Film , "https://media.vogue.fr/photos/5c2f4cca66249b0f58f396b9/2:3/w_1280,c_limit/mood_gosling_8365.jpeg");



      questionsList.add(question1);
      questionsList.add(question2);
      questionsList.add(question3);
      questionsList.add(question4);
      questionsList.add(question5);
      questionsList.add(question6);
      questionsList.add(question7);
      questionsList.add(question8);
      questionsList.add(question9);
      questionsList.add(question10);
      questionsList.add(question11);
      questionsList.add(question12);
      questionsList.add(question13);
      questionsList.add(question14);
      questionsList.add(question15);
      questionsList.add(question16);
      questionsList.add(question17);
      questionsList.add(question18);
    });

  }

  @override
  initState() {
    setListInit();
    super.initState();

  }
  
  
  setList(Question _question , String reponse) {
    setState(() {
      if (reponse.toLowerCase() == _question.rightAnswer.toLowerCase()) {
        _question.response = true;
      } else {
        _question.response = false;
      }
      questionsList.removeWhere((element) => element.content == _question.content);
      Question updateQuestion = Question(_question.id , _question.content , _question.rightAnswer , _question.propositions , false , _question.level , _question.category,  "" , _question.response);
      questionsList.add(updateQuestion);

    });
  }
  
  setResult(int _result) {
    setState(() {
      result = _result;
    });
  }

  changeList(String type , value) {
    setState(() {
      if (value == LEVELS.Niveau || value == CATEGORIES.Categories) {
        setListInit();
        return;
      }
      if (type == "categorie") {
        selectedCategory = value;
        questionsList = questionsList.where((element) => element.category == selectedCategory).toList();
      } else if (type == "level") {
        selectedLevel = value;
        questionsList = questionsList.where((element) => element.level == selectedLevel).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("KGB"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:  Padding (
                      padding: EdgeInsets.all(10.0),
                      child: DropdownButton<LEVELS>(
                        value: selectedLevel,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (LEVELS? value) {
                          // This is called when the user selects an item.
                          changeList("level" , value);
                        },
                        items: LEVELS.values.map<DropdownMenuItem<LEVELS>>((LEVELS value) {
                          return DropdownMenuItem<LEVELS>(
                            value: value,
                            child: Text(value.toString().split('.')[1]),
                          );
                        }).toList(),
                      ),
                    )
                ),
                Expanded(
                    child:  Container (
                      child: DropdownButton<CATEGORIES>(
                        value: selectedCategory,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (CATEGORIES? value) {
                          // This is called when the user selects an item.
                          changeList("categorie" , value);
                        },
                        items: CATEGORIES.values.map<DropdownMenuItem<CATEGORIES>>((CATEGORIES value) {
                          return DropdownMenuItem<CATEGORIES>(
                            value: value,
                            child: Text(value.toString().split('.')[1]),
                          );
                        }).toList(),
                      ),
                    )
                ),
              ],
            ),
            Expanded(child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: questionsList.length,
                itemBuilder: (context, index) {
                  return questionsList[index].active == true ? GestureDetector(
                    onTap: () {
                      _questionPage(
                          questionsList[index], setList, questionsList, setResult,
                          result);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(questionsList[index].content),
                      ),
                    ),
                  ) : Card(
                      color: questionsList[index].response! ? Colors.green[200] : Colors.red[200],
                      child: Row(
                        children: <Widget>[
                          Expanded(child: ListTile(
                            title: Text(questionsList[index].content),
                          ),),
                          Expanded(child: Icon(questionsList[index].response! ? Icons.check : Icons
                              .close))


                        ],
                      )
                  );
                }
            ),
            )

          ],
        )

              )
              );
  }

   _questionPage(Question question , setList , list , setResult , result) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Question'),
            ),
            body: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    QuestionPage(question : question , result: result , setList: setList , setResult: setResult , list: list)
                  ],
                )
              ],
            ),
            )
          );
        },
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key , required this.question , required this.result , required this.list , required this.setList , required this.setResult});

  final Question question;
  final int result;
  final List<Question> list;
  final setResult;
  final setList;
  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  TextEditingController inputController = TextEditingController();
  String response = "";
  int newResult = 0;

  checkResponse(){
    if (response.isEmpty) {
      _showMyDialogAlert();
    }
    setState(() {
      widget.setList(widget.question , response);
      if (response.toLowerCase() == widget.question.rightAnswer.toLowerCase()) {
         newResult = widget.result +1 ;
         widget.setResult(newResult);
      }
      Navigator.pop(context, newResult);
      List<Question> questionInactive = widget.list.where((element) => element.active == false).toList();
      if (questionInactive.length == widget.list.length) {
        _showMyDialogResult();
      }
      List<Question> falseResponse = widget.list.where((element) =>
      element.active == false && element.response == false
      ).toList();
      if (falseResponse.length >= 3) {
        _showMyDialogGameOver();
      }

    });
  }

  Future<void> _showMyDialogResult() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Résultat'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("${newResult.toString()} / ${widget.list.length}"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Retour'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
  Future<void> _showMyDialogAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Veuillez renseigner une réponse'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Retour'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showMyDialogGameOver() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("Vous avez eu 3 fautes"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Retour'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 410.0,
        width: 350,
        child:Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(widget.question.content)),
        Image.network(
          widget.question.image != null ?
          widget.question.image as String:
          'http://www.corinemarkey.com/service/wp-content/uploads/2018/05/Questionnement.jpg',
          height: 100,
        ),
        Expanded(child:
            widget.question.propositions.isNotEmpty ?
          ListView.builder(
          itemCount: widget.question.propositions.length,

            itemBuilder: (context, index) {
              return  Padding (
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 20.0,
                    width: 350,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.question.propositions[index]),
                            Checkbox(
                              checkColor: Colors.white,
                              value: response == widget.question.propositions[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    response = widget.question.propositions[index];
                                  } else {
                                    response = "";
                                  }
                                });
                              },
                            ),
                          ]
                      )
                  )
              );
            },
          ) :
            TextField(
            controller: inputController,
            onChanged: (v) => response =  v,
            decoration: const InputDecoration(
              labelText: 'réponse',
            )),
        ),
        TextButton(
          onPressed: checkResponse,
          child: const Text("Soumettre"),
        )
      ],
    ),
    );
  }
}
