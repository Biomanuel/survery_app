import 'package:breastcervicalcancersurvey_app/apptheme.dart';
import 'package:breastcervicalcancersurvey_app/src/models/breast_cancer_survey.dart';
import 'package:breastcervicalcancersurvey_app/src/models/cervical_cancer_survey.dart';
import 'package:breastcervicalcancersurvey_app/src/models/survey.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/german_question_view.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/lead_question_view.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/multi_choice.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/multi_selections.dart';
import 'package:flutter/material.dart';

import 'question_model.dart';

class QuestionsDb {
  int _qestionNumb = 0;
  bool _finished = false;
  bool _start = true;
  Survey survey;
  List<Question> _questionBank;

  QuestionsDb(String survey, userId) {
    if (survey == App.kBreastKey)
      this.survey = BreastCancerSurvey(userId);
    else
      this.survey = CervicalCancerSurvey(userId);
    _questionBank = this.survey.surveyQuestions;
  }

  nextQuestion() {
    if (_qestionNumb < _questionBank.length - 1)
      _qestionNumb++;
    else
      _finished = true;
    survey.calculateAnswered();
  }

  previousQuestion() {
    if (_qestionNumb > 0) {
      _qestionNumb--;
      _finished = false;
    } else
      _start = true;
    survey.calculateAnswered();
  }

  String getQuestionText() {
    return _questionBank[_qestionNumb].question;
  }

  Widget getQuestionWidget() {
    return _questionBank[_qestionNumb].QuestionWidget;
  }

  int getQuestionCount() {
    return _questionBank.length;
  }

  isFinished() {
    return _finished;
  }

  int currentQuestion() {
    return _qestionNumb;
  }

  resetQuestions() {
    _qestionNumb = 0;
    _finished = false;
  }
}
