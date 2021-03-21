import 'dart:math';

import 'package:breastcervicalcancersurvey_app/src/models/question_db.dart';
import 'package:breastcervicalcancersurvey_app/src/models/question_model.dart';
import 'package:breastcervicalcancersurvey_app/src/widgets/progress_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../apptheme.dart';
import '../welcome_screen.dart';
import 'dart:ui' as ui;

class MultiChoiceQuestion extends StatefulWidget {
  final bool reversed;
  final Question question;

  MultiChoiceQuestion({this.reversed = false, this.question});

  @override
  _MultiChoiceQuestionState createState() {
    return _MultiChoiceQuestionState(question);
  }
}

class _MultiChoiceQuestionState extends State<MultiChoiceQuestion>
    with TickerProviderStateMixin {
  Animation<double> transformAnimation;
  AnimationController _stepController;
  String selectionValue = 'Daily';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _textEditingController;

  _MultiChoiceQuestionState(Question question) {
    selectionValue = question.answered && question.answers.length > 0
        ? question.answers[0]
        : " ";
  }

  List<Option> usingOptions = [];

  @override
  void initState() {
    super.initState();

    _stepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    transformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _stepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _stepController.addListener(() {
      setState(() {});
    });

    if (!widget.reversed)
      forwardAnimation();
    else
      reverseAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _stepController.dispose();
  }

  Future forwardAnimation() async {
    try {
      await _stepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future reverseAnimation() async {
    try {
      await _stepController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    usingOptions = List<Option>.generate(
        widget.question.options.length,
        (index) => Option(
            widget.question.options[index], Random().nextInt(100).toString()));
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
                  curIndex: App.questionsDb.currentQuestion(),
                  stepCount: App.questionsDb.currentQuestion(),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 34.0),
                  child: Transform(
                    transform: new Matrix4.translationValues(
                        0.0, 50.0 * (1.0 - transformAnimation.value), 0.0),
                    child: Opacity(
                      opacity: transformAnimation.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            '${widget.question.getReference()["section"]}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            '${widget.question.getReference()["number"]}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text('${widget.question.question}')),
                          Expanded(
                            child: Container(
                              child: TextField(
                                controller: _textEditingController,
                                style: TextStyle(fontSize: 28),
                                // minFontSize: 14,
                                maxLines: 3,
                                onChanged: (text) {
                                  setState(() {
                                    if (text.isNotEmpty) {
                                      widget.question.answers = [text];
                                      widget.question.answered = true;
                                    }
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                  App.questionsDb.previousQuestion();
                });
                Navigator.pop(context);
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
                    App.questionsDb.nextQuestion();
                    if (App.questionsDb.isFinished()) {
                      _firestore.collection(App.kBreastKey).add(null);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Welcome()));
                    } else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  App.questionsDb.getQuestionWidget()));
                  });
                },
                child: Center(
                    child: Text(
                  App.questionsDb.currentQuestion() <
                          App.questionsDb.getQuestionCount() - 1
                      ? 'Continue'
                      : 'Finish',
                  style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Option {
  final String identifier;
  final String displayContent;

  Option(this.displayContent, this.identifier);
}
