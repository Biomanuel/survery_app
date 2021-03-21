import 'package:breastcervicalcancersurvey_app/src/breast/start_page.dart';
import 'package:breastcervicalcancersurvey_app/src/cervical/start_page.dart';
import 'package:breastcervicalcancersurvey_app/src/models/survey.dart';
import 'package:breastcervicalcancersurvey_app/src/view_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apptheme.dart';
import 'answers_list_page.dart';
import 'auth.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String email;
  bool fireInited = false;
  void initializeFirebase() async {
    email = await App.getCurrentUserId();
    await Firebase.initializeApp().whenComplete(() {
      print("Firebase Initialization completed");
      setState(() {
        fireInited = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    App.getCurrentSurveyKey();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: FutureBuilder<bool>(
              future: initialized(),
              builder: (context, snapshot) {
                if (email == null || email.isEmpty) {
                  return Scaffold(
                    body: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else {
                  if (snapshot != null && snapshot.data != null) {
                    bool initialized = snapshot.data;
                    if (!initialized) {
                      return Scaffold(
                        body: Container(
                          color: Colors.white,
                          child: SafeArea(
                            top: false,
                            child: Scaffold(
                              backgroundColor: Colors.white,
                              body: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 48 +
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top,
                                            left: 16,
                                            right: 16,
                                            bottom: 24),
                                        child: Image.asset(
                                            'assets/images/survey_illustration.png'),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Welcome',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: App.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.only(top: 16),
                                        child: const Text(
                                          'Please, select which survey you will like to use this app for',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      // _buildComposer(),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: Container(
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: App.primaryAccentColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  await App.initializeApp(
                                                      App.kBreastKey);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BreastStartPage()));
                                                },
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      'Breast Cancer',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: Container(
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.amber[700],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4.0)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                    offset: const Offset(4, 4),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  await App.initializeApp(
                                                      App.kCervicalKey);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CervicalStartPage()));
                                                },
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      'Cervical Cancer',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Scaffold(
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Survey Overview",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(minHeight: 30),
                              child: Center(
                                  child: Text(
                                "This shows an overview of ${App.kCurrentSurveyKey.replaceAll("Survey", '')} Cancer survey you have done so far",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              )),
                            ),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection(App.kCurrentSurveyKey)
                                      .where("userId", isEqualTo: email)
                                      .where("deleted", isEqualTo: false)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return Center(child: Text("Loading..."));
                                    return ListView.builder(
                                      itemExtent: 90.0,
                                      padding: EdgeInsets.only(
                                          bottom: 40, right: 8, left: 8),
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) =>
                                          _buildListItem(context,
                                              snapshot.data.docs[index], index),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllPage()));
                          },
                          tooltip: "Show all recorded surveys",
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.format_align_left_sharp,
                            size: 32,
                          ),
                        ),
                      );
                    }
                  } else {
                    return Scaffold(
                      body: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                }
              }),
        ),
        Visibility(
          visible: email == null || email.isEmpty,
          child: AlertDialog(
            content: AuthDialog(
              init: fireInited,
              callback: (completed) async {
                email = await App.getCurrentUserId();
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> initialized() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var initialized = prefs.getBool(App.kInitializeKey);
    if (initialized == null) initialized = false;
    return initialized;
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
