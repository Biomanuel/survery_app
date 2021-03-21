import 'package:breastcervicalcancersurvey_app/apptheme.dart';
import 'package:breastcervicalcancersurvey_app/src/models/question_db.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/multi_choice.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/multi_selections.dart';
import 'package:breastcervicalcancersurvey_app/src/welcome_screen.dart';
import 'package:breastcervicalcancersurvey_app/src/widgets/progress_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../animated_box.dart';

QuestionsDb questionsDb = new QuestionsDb(App.kCervicalKey, "");

class CervicalSurveyMachine extends StatefulWidget {
  @override
  _CervicalSurveyMachineState createState() => _CervicalSurveyMachineState();
}

class _CervicalSurveyMachineState extends State<CervicalSurveyMachine>
    with TickerProviderStateMixin {
  AnimationController _animateController;
  AnimationController _longPressController;
  AnimationController _fourStepController;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  double overall = 3.0;
  String overallStatus = "Good";
  int curIndex = 0;

  bool isFairly = false;
  bool isClear = false;
  bool isEasy = false;
  bool isFriendly = false;

  final secondQuestion = MultiChoiceQuestion();
  final thirdQuestionPage = MultiSelectionQuestionView();

  Animation<double> longPressAnimation;

  Animation<double> fourTransformAnimation;

  @override
  void initState() {
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _longPressController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fourStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    longPressAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
            parent: _longPressController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    fourTransformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fourStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _longPressController.addListener(() {
      setState(() {});
    });

    _fourStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
    _fourStepController.dispose();
    _longPressController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
//                color: Colors.blue,
                margin: EdgeInsets.only(top: 30.0),
                height: 10.0,
                child: ProgressStepper(
                  width: _width,
                  curIndex: questionsDb.currentQuestion(),
                  stepCount: questionsDb.currentQuestion(),
                ),
              ),
              questionsDb.getQuestionWidget(),
              // curIndex == 0
              //     ? _getFirstStep()
              //     : curIndex == 1
              //         ? secondQuestion
              //         : curIndex == 2
              //             ? thirdQuestionPage
              //             : _getFourStep(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      // TODO: do something here
                      setState(() {
                        questionsDb.previousQuestion();
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: Icon(
                        Icons.chevron_left,
                        size: 36,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          questionsDb.nextQuestion();
                          curIndex += 1;
                          if (curIndex == 1) {
                            // secondQuestion.startSecondStepAnimation();
                          } else if (curIndex == 2) {
                            // _startThirdStepAnimation();
                          } else if (curIndex == 3) {
                            // _startFourStepAnimation();
                          }
                          if (questionsDb.isFinished()) {
                            _firestore
                                .collection(App.kBreastKey)
                                .doc(questionsDb.survey.surveyId)
                                .set(questionsDb.survey.toMap());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Welcome()));
                          }
                        });
                      },
                      child: Center(
                          child: Text(
                        questionsDb.currentQuestion() <
                                questionsDb.getQuestionCount() - 1
                            ? 'Continue'
                            : 'Finish',
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.orangeAccent),
                      )),
                    ),
                  ),
                ],
              ),
            ))
          : null,
    );
  }
}
