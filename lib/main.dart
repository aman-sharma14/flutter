// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application/questions/BMI.dart';
import 'package:flutter_application/questions/all.dart';
import 'package:flutter_application/questions/question4.dart';
import 'package:flutter_application/questions/question5.dart';
import 'package:flutter_application/questions/question8.dart';
import 'package:flutter_application/questions/todo.dart';
import 'package:flutter_application/topics/topics.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, home: Scaffold(body: SplashScreen())));
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: 
            Image.network(
              "https://upload.wikimedia.org/wikipedia/en/e/e5/St._Xavier%27s_College%2C_Mumbai_crest.png",
              height: 300,
              width: double.infinity,
            ),
            // Image.asset("assets\\images\\loading.gif",height: 200,width: 200,)
            
          ),
          SizedBox(
            height: 20,
          ),
          Text("caption")
        ],
      ),
      duration: 1500,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: Duration(milliseconds: 1000),
      pageTransitionType: PageTransitionType.fade,
      nextScreen: TaskManager(),
    );
  }
}
