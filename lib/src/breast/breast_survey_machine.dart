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

class BreastSurveyMachine extends StatefulWidget {
  @override
  _BreastSurveyMachineState createState() => _BreastSurveyMachineState();
}

class _BreastSurveyMachineState extends State<BreastSurveyMachine>
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
  QuestionsDb questionsDb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    questionsDb = new QuestionsDb(App.kBreastKey, "");

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

  Future _startLongPressAnimation() async {
    try {
      await _longPressController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFourStepAnimation() async {
    try {
      await _fourStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _reverseFourStepAnimation() async {
    try {
      await _fourStepController.reverse().orCancel;
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
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
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
                      if (curIndex == 1) {
                        // secondQuestion.startSecondStepAnimation();
                      } else if (curIndex == 2) {
                        // _startThirdStepAnimation();
                        // _reverseThirdStepAnimation();
                      } else if (curIndex == 3) {
                        await _reverseFourStepAnimation();
                        //_startThirdStepAnimation();
                      }
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
                            _firestore.collection(App.kBreastKey).add(null);
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

  Widget getPages(double _width) {
    return Column(
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
    );
  }

  Widget _getFirstStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Question 1'),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text('Overall, how would you rate our service?')),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                overallStatus,
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Slider(
                  value: overall,
                  onChanged: (value) {
                    setState(() {
                      overall = value.round().toDouble();
                      _getOverallStatus(overall);
                    });
                  },
                  label: '${overall.toInt()}',
                  divisions: 30,
                  min: 1.0,
                  max: 5.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getFourStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - fourTransformAnimation.value), 0.0),
          child: Opacity(
            opacity: fourTransformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 4'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text(
                        'When you need help or has concerns related with our product, how satisfied are you with our customer support\'s performance?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 213.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
//                              onTapU
//                        onLongPress: () {
//                          _startLongPressAnimation();
//                          },
//                                onTapUp: (detail) {
//                          print(detail);
//                         _longPressController.reset();
//                      },
                                      onTapUp: (detail) {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder:
                                        //             (BuildContext context) =>
                                        //                 LastPage(
                                        //                   statusType: 'Unhappy',
                                        //                 )));
                                      },
                                      child: Transform.scale(
                                          scale: longPressAnimation.value,
                                          child: Hero(
                                            tag: 'Unhappy',
                                            child: Image.asset(
                                              'images/angry.gif',
                                              width: 50.0,
                                              height: 50.0,
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Unhappy'),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
//                              onTapU
//                        onLongPress: () {
//                          _startLongPressAnimation();
//                          },
//                                onTapUp: (detail) {
//                          print(detail);
//                         _longPressController.reset();
//                      },
                                      onTapUp: (detail) {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder:
                                        //             (BuildContext context) =>
                                        //                 LastPage(
                                        //                   statusType: 'Neutral',
                                        //                 )));
                                      },
                                      child: Hero(
                                        tag: 'Neutral',
                                        child: Transform.scale(
                                            scale: longPressAnimation.value,
                                            child: Image.asset(
                                              'images/mmm.gif',
                                              width: 50.0,
                                              height: 50.0,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Neutral'),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
//                              onTapU
//                        onLongPress: () {
//                          _startLongPressAnimation();
//                          },
//                                onTapUp: (detail) {
//                          print(detail);
//                         _longPressController.reset();
//                      },
                                      onTapUp: (detail) {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder:
                                        //             (BuildContext context) =>
                                        //                 LastPage(
                                        //                   statusType:
                                        //                       'Satisfied',
                                        //                 )));
                                      },
                                      child: Transform.scale(
                                          scale: longPressAnimation.value,
                                          child: Hero(
                                            tag: 'Satisfied',
                                            child: Image.asset(
                                              'images/hearteyes.gif',
                                              width: 50.0,
                                              height: 50.0,
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Satisfied'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getOverallStatus(double overall) {
    switch (overall.toInt()) {
      case 1:
        overallStatus = 'Bad';
        break;
      case 2:
        overallStatus = 'Normal';
        break;
      case 3:
        overallStatus = 'Good';
        break;
      case 4:
        overallStatus = 'Very Good';
        break;
      default:
        overallStatus = 'Excellent';
        break;
    }
  }
}
