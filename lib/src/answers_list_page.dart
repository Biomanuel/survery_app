import 'package:breastcervicalcancersurvey_app/src/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'models/survey.dart';

class AnswersList extends StatefulWidget {
  final Survey survey;

  AnswersList(this.survey);

  @override
  _AnswersListState createState() => _AnswersListState();
}

class _AnswersListState extends State<AnswersList> {
  @override
  Widget build(BuildContext context) {
    Function getQuestions = () {
      List<Question> quess = [];
      for (Question question in widget.survey.surveyQuestions)
        if (question.type != QuestionType.leadQuestion) quess.add(question);
      return quess;
    };
    List<Question> questions = getQuestions();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Survey Overview",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            Expanded(
              child: ListView.builder(
                //itemExtent: 90.0,
                padding: EdgeInsets.only(bottom: 40, right: 8, left: 8),
                itemCount: questions.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, questions[index], index),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Question question, index) {
    Function getAnswers = () {
      String answer = "";
      for (String ans in question.answers) {
        answer = answer + ans + ',' + '\n';
      }
      return answer;
    };
    String answer = getAnswers();
    return Container(
      margin: EdgeInsets.all(8.0),
      constraints: BoxConstraints(minHeight: 60),
      color: Colors.grey.shade300,
      child: Center(
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${index + 1}."),
            ],
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Question: "),
              Expanded(
                child: Text(
                  "${question.question}",
                  maxLines: 4,
                  softWrap: true,
                ),
              ),
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Answers: "),
              Expanded(
                child: Text(
                  "${answer}",
                  maxLines: 10,
                  softWrap: true,
                ),
              ),
            ],
          ),
          trailing: true
              ? null
              : InkWell(
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       title: Text("Delete Survey"),
                    //       content: Text("Are you sure?"),
                    //       actions: [
                    //         FlatButton(
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //             },
                    //             child: Text("No")),
                    //         FlatButton(
                    //             onPressed: () async {
                    //               Navigator.pop(context);
                    //             },
                    //             child: Text("Yes")),
                    //       ],
                    //     ));
                    Fluttertoast.showToast(
                        msg:
                            "Sorry you can't edit an already submitted survey");
                  },
                  child: Icon(Icons.edit)),
        ),
      ),
    );
  }
}
