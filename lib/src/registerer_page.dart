import 'package:breastcervicalcancersurvey_app/apptheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'answers_list_page.dart';
import 'models/registerer.dart';
import 'models/survey.dart';

class RegistererPage extends StatefulWidget {
  final Registerer registerer;

  RegistererPage(this.registerer);

  @override
  _RegistererPageState createState() => _RegistererPageState();
}

class _RegistererPageState extends State<RegistererPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.registerer.email}"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            constraints: BoxConstraints(minHeight: 30),
            child: Center(
                child: Text(
              "This shows an overview of surveys ${widget.registerer.userDetails} has done so far",
              maxLines: 3,
              textAlign: TextAlign.center,
            )),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(App.kCurrentSurveyKey)
                    .where("userId", isEqualTo: widget.registerer.email)
                    .where("deleted", isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Text("Loading..."));
                  return ListView.builder(
                    itemExtent: 90.0,
                    padding: EdgeInsets.only(bottom: 40, right: 8, left: 8),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) => _buildListItem(
                        context, snapshot.data.docs[index], index),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
      BuildContext context, QueryDocumentSnapshot doc, index) {
    Survey survey = Survey.fromSnapshot(doc);
    return Container(
      margin: EdgeInsets.all(8.0),
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
            child: Row(
              children: [
                Text("Answered Questions: "),
                Text(
                    "${survey.answeredQuestionsCount} / ${survey.getTotalQuestions()}"),
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
