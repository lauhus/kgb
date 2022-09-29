import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        fontFamily: "Oswald"
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

  @override
  initState() {
    Question question1 = Question(0, "Le ciel est-il bleu?" , "oui", [ "oui" , "non" ] , true);
    Question question2 = Question(1, "L'herbe est-elle verte?" , "oui", [ "oui" , "non" ] , true);
    Question question3 = Question(2, "Les chats font-ils miaou ?" , "oui", [ "oui" , "non" ], true);
    Question question4 = Question(3, "Les chiens font-ils ouafs?" , "oui", [ "oui" , "non" ] , true);
    Question question5 = Question(4, "Quel jours somme-nous?" , "29", [], true);
    Question question6 = Question(5, "Quel es ce personnage ?" , "Harry potter" , [] , true , "https://media-mcetv.ouest-france.fr/wp-content/uploads/2022/09/harry-potter-top-10-des-fois-ou-les-mechants-ont-ete-justes-.jpeg");


    questionsList.add(question1);
    questionsList.add(question2);
    questionsList.add(question3);
    questionsList.add(question4);
    questionsList.add(question5);
    questionsList.add(question6);

    super.initState();

  }
  
  
  setList(Question _question) {
    setState(() {
      questionsList.removeWhere((element) => element.content == _question.content);
      Question updateQuestion = Question(_question.id , _question.content , _question.rightAnswer , _question.propositions , false);
      questionsList.add(updateQuestion);

    });
  }
  
  setResult(int _result) {
    setState(() {
      result = _result;
    });
  }


  @override
  Widget build(BuildContext context) {
    log('result : $result');
    return Scaffold(
      appBar: AppBar(

        title: const Text("KGB"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: questionsList.length,
            itemBuilder: (context, index) {
              return  questionsList[index].active == true ? GestureDetector(
                onTap: (){ _questionPage(questionsList[index] , setList , questionsList ,  setResult , result);},
                child: Card(
                    child: ListTile(
                      title: Text(questionsList[index].content),
                    ),
                ),
              ) : Card(
                  color: Colors.grey[700],
                  child: ListTile(
                  title: Text(questionsList[index].content),
                  ),
              );
            }),
       ),
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
      widget.setList(widget.question);
      if (response.toLowerCase() == widget.question.rightAnswer.toLowerCase()) {
         newResult = widget.result +1 ;
         widget.setResult(newResult);
      }
      Navigator.pop(context, newResult);
      List<Question> questionInactive = widget.list.where((element) => element.active == false).toList();
      if (questionInactive.length == widget.list.length) {
        _showMyDialogResult();
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400.0,
        width: 200.0,
        child:Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.question.content),
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
              return  Container(
                  height: 150.0,
                    child: Row(
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
          child: const Text("Sousmettre"),
        )
      ],
    ),
    );
  }
}
