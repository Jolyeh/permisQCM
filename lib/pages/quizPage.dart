import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/qcm.dart';
import '../compnents/questionCard.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    var nbreQuiz = qcm[0]["questions"].length;
    var index = [];
    var pagecontroller = PageController();
    for(var i=0; i < nbreQuiz; i++){
      index.add(i);
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: blanc,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              pagecontroller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
            },
            child: Text('Sauter',
              style: TextStyle(
                fontSize: 18,
                color: blanc
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: hauteur,
        width: largeur,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/bg.png'), fit: BoxFit.cover),
        ),
        child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: pagecontroller,
            itemCount: index.length,
            itemBuilder: (context, index) => QuestionCard(index: index, pageController: pagecontroller,),
        )
      ),
    );
  }
}
