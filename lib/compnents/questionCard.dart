import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/resultatPage.dart';
import '../theme/theme.dart';
import '../models/qcm.dart';
import '../models/points.dart';

class QuestionCard extends StatefulWidget {
  int? index;
  final PageController pageController;
  QuestionCard({super.key, required this.index, required this.pageController});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  Timer? _timer;
  int _start = 20;

  get timer => _timer;



  @override
  void initState() {
    super.initState();
    startTimer();
  }
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        timer.cancel();
        nextPage();
      }
    });
  }
  void stopTimer(){
    if(_timer !=null){
      _timer!.cancel();
      _timer = null;
    }
  }
  void nextPage() {
    widget.pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);

  }
  @override
  Widget build(BuildContext context) {
    PageController pageController;
    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    var nbreQuiz = qcm[0]["questions"].length;
    var quizActu = widget.index! + 1;
    bool reponse = false;
    void score(){
      if(reponse == true){
        points.add(10);
      }else{
        points.add(0);
      }

    }
    void verfication(){
      if (reponse == true){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return SimpleDialog(
                backgroundColor: bleu,
                insetPadding: EdgeInsets.all(15),
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
                title: Center(
                  child: Text('Reponse',
                    style: TextStyle(
                        fontSize: 22,
                        color: blanc
                    ),
                  ),
                ),
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(qcm[0]["questions"][widget.index]["feedback"],
                      style: TextStyle(
                          fontSize: 16,
                          color: blanc
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: OutlinedButton(
                      onPressed: () {
                        score();
                        if(nbreQuiz == quizActu){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResultatPage(total: nbreQuiz,),));
                        }else{
                          Navigator.pop(context);
                          nextPage();
                        }
                      },
                      child: Text("Ok",
                        style: TextStyle(
                            fontSize: 16,
                            color: blanc
                        ),
                      ),
                      style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: blanc)),),
                    ),
                  )
                ],
              );
            }
        );
      }
      else{
        showDialog(
            context: context,
            builder: (BuildContext context){
              return SimpleDialog(
                backgroundColor: bleu,
                insetPadding: EdgeInsets.all(15),
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
                title: Center(
                  child: Text('Reponse',
                    style: TextStyle(
                        fontSize: 22,
                        color: blanc
                    ),
                  ),
                ),
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(qcm[0]["questions"][widget.index]["falsehint"],
                      style: TextStyle(
                          fontSize: 16,
                          color: blanc
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: OutlinedButton(
                      onPressed: () {
                        score();
                        if(nbreQuiz == quizActu){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResultatPage(total: nbreQuiz,),));
                        }else{
                          Navigator.pop(context);
                          nextPage();
                        }
                      },
                      child: Text("Ok",
                        style: TextStyle(
                            fontSize: 16,
                            color: blanc
                        ),
                      ),
                      style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: blanc)),),
                    ),
                  )
                ],
              );
            }
        );
      };
      stopTimer();
    }
    return Container(
      height: hauteur,
      width: largeur,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/bg.png'), fit: BoxFit.cover),
      ),
      child: ListView(
        padding: EdgeInsets.only(right: 15, left: 15, bottom: 15, top: hauteur/8),
        children: [
          Container(
            height: 35,
            width: largeur,
            padding: EdgeInsets.only(right: 10, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$_start sec",
                  style: TextStyle(
                      color: blanc,
                      fontSize: 16
                  ),
                ),
                Icon(Icons.timelapse, color: blanc,)
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: blanc)
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Question ",
                style: TextStyle(
                    fontSize: 20,
                    color: gris
                ),
              ),
              Text("$quizActu/",
                style: TextStyle(
                    fontSize: 25,
                    color: gris
                ),
              ),
              Text("$nbreQuiz",
                style: TextStyle(
                    fontSize: 18,
                    color: gris
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            height: hauteur-250,
            width: largeur,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: blanc
            ),
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                Text(qcm[0]["questions"][widget.index]['questionText']['text'],
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      reponse = qcm[0]["questions"][widget.index]['options'][0]["isCorrect"];
                      verfication();
                    },
                    child: Text(qcm[0]["questions"][widget.index]['options'][0]["optionText"]['text']+'.  '+qcm[0]["questions"][widget.index]['options'][0]["optionText"]['reponse'],
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      foregroundColor: MaterialStatePropertyAll(bleu),
                      side: MaterialStatePropertyAll(BorderSide(color: bleu,)),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      reponse = qcm[0]["questions"][widget.index]['options'][1]["isCorrect"];
                      verfication();
                    },
                    child: Text(qcm[0]["questions"][widget.index]['options'][1]["optionText"]['text']+'.  '+qcm[0]["questions"][widget.index]['options'][1]["optionText"]['reponse'],
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      foregroundColor: MaterialStatePropertyAll(bleu),
                      side: MaterialStatePropertyAll(BorderSide(color: bleu)),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      reponse = qcm[0]["questions"][widget.index]['options'][2]["isCorrect"];
                      verfication();
                    },
                    child: Text(qcm[0]["questions"][widget.index]['options'][2]["optionText"]['text']+'.  '+qcm[0]["questions"][widget.index]['options'][2]["optionText"]['reponse'],
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      foregroundColor: MaterialStatePropertyAll(bleu),
                      side: MaterialStatePropertyAll(BorderSide(color: bleu)),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      reponse = qcm[0]["questions"][widget.index]['options'][3]["isCorrect"];
                      verfication();
                    },
                    child: Text(qcm[0]["questions"][widget.index]['options'][3]["optionText"]['text']+'.  '+qcm[0]["questions"][widget.index]['options'][3]["optionText"]['reponse'],
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      foregroundColor: MaterialStatePropertyAll(bleu),
                      side: MaterialStatePropertyAll(BorderSide(color: bleu)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
