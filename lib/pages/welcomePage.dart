import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/qcm.dart';
import 'quizPage.dart';
import '../models/points.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    var largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: hauteur,
        width: largeur,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/bg.png'), fit: BoxFit.cover),
        ),
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(height: hauteur/3.5,),
            Icon(Icons.car_crash_outlined, color: blanc, size: 100,),
            SizedBox(height: 30,),
            Text(qcm[0]["title"],
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: blanc
              ),
            ),
            Text(qcm[0]["description"],
              style: TextStyle(
                  fontSize: 16,
                color: gris
              ),
            ),
            SizedBox(height: 200,),
            InkWell(
              onTap: () {
                points.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(),));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: largeur,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bleu
                ),
                child: Text("Commencer", style: TextStyle(fontSize: 18, color: blanc),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
