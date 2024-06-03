import 'package:flutter/material.dart';
import '../pages/quizPage.dart';
import '../models/qcm.dart';
import '../theme/theme.dart';
import '../models/points.dart';
import '../models/jsonTry.dart';

class ResultatPage extends StatelessWidget {
  var total;
  ResultatPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    var score = 0;
    total = total * 10;
    var text = '';
    for (var i=0; i < points.length; i++){
      score = score + points[i];
    }

    if(score >= qcm[0]["passingScore"] ){
      text = qcm[0]["feedbackMessage"];
    }else{
      text = qcm[0]["failureMessage"];
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: hauteur,
        width: largeur,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/bg.png'), fit: BoxFit.cover),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: hauteur/4.5, right: 30, left: 30),
          children: [
            Container(
              height: hauteur-300,
              width: largeur-200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: blanc.withOpacity(0.75)
              ),
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Text('Resultat du test au permis de conduire',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: bleu
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  Text('Votre score: $score / $total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  Text('$text',
                    style: TextStyle(
                        fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      points.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(),));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: largeur,
                      decoration: BoxDecoration(
                        color: bleu,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text('Réssayer',
                        style: TextStyle(
                          fontSize: 20,
                          color: blanc
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //JsonTry()
          ],
        ),
      ),
    );
  }
}


