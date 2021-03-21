import 'package:breastcervicalcancersurvey_app/src/models/survey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../answers_list_page.dart';

class SurveyListItem extends StatelessWidget {
  SurveyListItem({this.doc, this.index});

  final int index;
  final QueryDocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    final Survey survey = Survey.fromSnapshot(doc);
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
          title: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AnswersList(survey))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("TimeStamp: "),
                Expanded(
                  child: Text(
                    survey.timeStamp,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          subtitle: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AnswersList(survey))),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Answered Questions: "),
                    Text(
                        "${survey.answeredQuestionsCount} / ${survey.getTotalQuestions()}"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register's Email: "),
                    Expanded(
                      child: Text(
                        "${survey.userId}",
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register's Details: "),
                    Expanded(
                      child: Text(
                        "${survey.userDetail}",
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          trailing: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Delete Survey"),
                          content: Text("Are you sure?"),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No")),
                            FlatButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance.runTransaction(
                                      (transaction) async {
                                    DocumentSnapshot freshSnap =
                                        await transaction.get(doc.reference);
                                    transaction.update(
                                        freshSnap.reference, {"deleted": true});
                                  }).whenComplete(() => Fluttertoast.showToast(
                                      msg:
                                          "You deleted a survey: ${survey.surveyId}"));
                                  Navigator.pop(context);
                                },
                                child: Text("Yes")),
                          ],
                        ));
              },
              child: Icon(Icons.delete)),
        ),
      ),
    );
  }
}
