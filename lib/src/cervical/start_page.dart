import 'package:breastcervicalcancersurvey_app/src/cervical/cervical_survey_machine.dart';
import 'package:flutter/material.dart';

import '../../apptheme.dart';
import '../animated_box.dart';
import 'dart:ui' as ui;

class CervicalStartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<CervicalStartPage>
    with TickerProviderStateMixin {
  AnimationController _animateController;

  @override
  void initState() {
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimationBox(
          controller: _animateController,
          screenWidth: _width - 32.0,
          onStartAnimation: () {
            _startAnimation();
            App.initializeSurvey(App.kCervicalKey);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => App.questionsDb.getQuestionWidget()));
          },
        ),
      ),
    );
  }
}
