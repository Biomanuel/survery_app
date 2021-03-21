import 'package:breastcervicalcancersurvey_app/src/question_widgets/german_question_view.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/lead_question_view.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/multi_choice.dart';
import 'package:breastcervicalcancersurvey_app/src/question_widgets/multi_selections.dart';
import 'package:flutter/cupertino.dart';

class Question {
  String questionId;
  String question;
  QuestionType type;
  List<String> options = [];
  List<String> answers = [];
  bool _answered = false;
  Widget QuestionWidget;

  Map<String, dynamic> toMap() {
    return {
      "questionId": questionId,
      "question": question,
      "answers": answers,
      "options": options,
      "answered": answered,
      "type": type.toString(),
    };
  }

  Question.fromMap(Map<String, dynamic> data) {
    questionId = data['questionId'];
    question = data['question'];
    answers = getStringList(data);
    options = getStringOptions(data);
    answered = data['answered'];
    // TODO: Write a method to convert the type properly
    type = convertType(data['type']);
  }

  QuestionType convertType(String type) {
    for (QuestionType typ in QuestionType.values)
      if (type == typ.toString()) return typ;
  }

  List<String> getStringList(Map<String, dynamic> data) {
    List<dynamic> thelist = data['answers'] ?? [];
    List<String> thestrings = [];
    for (dynamic dyna in thelist) thestrings.add(dyna.toString());
    return thestrings;
  }

  List<String> getStringOptions(Map<String, dynamic> data) {
    List<dynamic> thelist = data['options'] ?? [];
    List<String> thestrings = [];
    for (dynamic dyna in thelist) thestrings.add(dyna.toString());
    return thestrings;
  }

  Question(
      {this.questionId, this.question, this.type, this.options, this.answers}) {
    switch (this.type) {
      case QuestionType.multiChoice:
        QuestionWidget = MultiChoiceQuestion(
          question: this,
        );
        break;
      case QuestionType.multipleSelection:
        QuestionWidget = MultiSelectionQuestionView(
          question: this,
        );
        break;
      case QuestionType.german:
        QuestionWidget = GermanQuestionView(
          question: this,
        );
        break;
      case QuestionType.leadQuestion:
        QuestionWidget = LeadQuestionView(
          question: this,
        );
        break;
      default:
        QuestionWidget = GermanQuestionView(
          question: this,
        );
    }
  }

  bool get answered => _answered;

  set answered(bool value) {
    _answered = value;
  }

  Map<String, String> getReference() {
    List<String> qIdSplit = questionId.split("-");
    return {
      "section": qIdSplit[0].replaceAll("_", " "),
      "number": qIdSplit[1].replaceAll("q", "Question "),
    };
  }
}

enum QuestionType {
  german,
  multiChoice,
  multipleSelection,
  germanMultiple,
  leadQuestion
}
