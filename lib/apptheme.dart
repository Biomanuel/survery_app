import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/models/question_db.dart';

class App {
  // Colors
  static Color primaryColor = Colors.red;
  static Color primaryAccentColor = Colors.green.shade300;

  static QuestionsDb questionsDb;

  // Constants
  static const String kInitializeKey = "initialize";
  static const String kSurveyKey = "survey";
  static const String kUserIdKey = "userId";
  static const String kBreastKey = "BreastSurvey";
  static const String kCervicalKey = "CervicalSurvey";
  static String kCurrentSurveyKey = "";
  static String kCurrentUserId;
  static String userDetail = "";

  static const kAuthTextFieldDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.black),
    hintText: 'Enter your password.',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );

  static void initializeSurvey(String surveyKey) async {
    String userId = await App.getCurrentUserId();
    questionsDb = new QuestionsDb(surveyKey, userId);
    questionsDb.survey.userDetail = userDetail;
    kCurrentSurveyKey = surveyKey;
  }

  static Future<String> getCurrentSurveyKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    kCurrentSurveyKey = pref.getString(App.kSurveyKey);
    return kCurrentSurveyKey;
  }

  static Future<bool> initializeApp(String surveyKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool set = await pref.setBool(App.kInitializeKey, true);
    pref.setString(App.kSurveyKey, surveyKey);
    return set;
  }

  static Future<String> getCurrentUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    kCurrentUserId = pref.getString(App.kUserIdKey);
    return kCurrentUserId;
  }

  static Future<bool> storeCurrentUserId(String userid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool set = await pref.setString(kUserIdKey, userid);
    return set;
  }

  static Route createRoute({nextPage, bool reverse}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionDuration: const Duration(seconds: 2),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(reverse ?? false ? -2.0 : 2.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
