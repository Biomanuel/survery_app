import 'package:breastcervicalcancersurvey_app/src/models/breast_cancer_survey.dart';
import 'package:breastcervicalcancersurvey_app/src/models/registerer.dart';
import 'package:breastcervicalcancersurvey_app/src/utilities/csv_creator.dart';
import 'package:breastcervicalcancersurvey_app/src/widgets/survey_list_item.dart';
import 'package:breastcervicalcancersurvey_app/src/widgets/user_list_item.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../apptheme.dart';
import 'models/survey.dart';

class ViewAllPage extends StatefulWidget {
  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  bool displayBreastSurveys = true;
  bool displayBreastRegisters = true;
  bool filterByUser = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Visibility(
            visible: !filterByUser,
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "All Surveys",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    constraints: BoxConstraints(minHeight: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Center(
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                color: App.primaryAccentColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(4, 4),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      displayBreastSurveys = true;
                                    });
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Breast Cancer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(4, 4),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      displayBreastSurveys = false;
                                    });
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Cervical Cancer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
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
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    constraints: BoxConstraints(minHeight: 30),
                    child: Center(
                        child: Text(
                      "This is showing all ${displayBreastSurveys ? App.kBreastKey.replaceAll("Survey", '') : App.kCervicalKey.replaceAll("Survey", '')} cancer survey done so far",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Visibility(
                          visible: displayBreastSurveys,
                          child: PaginateFirestore(
                            //item builder type is compulsory.
                            itemBuilderType: PaginateBuilderType
                                .listView, //Change types accordingly
                            itemBuilder: (index, context, documentSnapshot) =>
                                SurveyListItem(
                              doc: documentSnapshot,
                              index: index,
                            ),
                            // orderBy is compulsory to enable pagination
                            query: FirebaseFirestore.instance
                                .collection(App.kBreastKey)
                                .where("deleted", isEqualTo: false),
                            // to fetch real-time data
                            isLive: true,
                          ),
                        ),
                        Visibility(
                          visible: !displayBreastSurveys,
                          child: PaginateFirestore(
                            //item builder type is compulsory.
                            itemBuilderType: PaginateBuilderType
                                .listView, //Change types accordingly
                            itemBuilder: (index, context, documentSnapshot) =>
                                SurveyListItem(
                              doc: documentSnapshot,
                              index: index,
                            ),
                            // orderBy is compulsory to enable pagination
                            query: FirebaseFirestore.instance
                                .collection(App.kCervicalKey)
                                .where("deleted", isEqualTo: false),
                            // to fetch real-time data
                            isLive: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  setState(() {
                    filterByUser = !filterByUser;
                  });

                  // convertToCSV();

                  return;
                },
                tooltip: "Users List",
                backgroundColor: Colors.green,
                child: Icon(
                  !filterByUser ? Icons.people : Icons.list_alt,
                  size: 32,
                ),
              ),
            ),
          ),
          Visibility(
            visible: filterByUser,
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "All Surveys",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    constraints: BoxConstraints(minHeight: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Center(
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                color: App.primaryAccentColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(4, 4),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      displayBreastRegisters = true;
                                    });
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Breast Cancer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(4, 4),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    setState(() {
                                      displayBreastRegisters = false;
                                    });
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Cervical Cancer',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
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
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    constraints: BoxConstraints(minHeight: 30),
                    child: Center(
                        child: Text(
                      "This is showing all ${displayBreastSurveys ? App.kBreastKey.replaceAll("Survey", '') : App.kCervicalKey.replaceAll("Survey", '')} cancer survey registrars",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Visibility(
                          visible: displayBreastRegisters,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(App.kBreastKey)
                                  .where("deleted", isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Center(child: Text("Loading..."));
                                return buildUsersList(snapshot);
                              }),
                        ),
                        Visibility(
                          visible: !displayBreastRegisters,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(App.kCervicalKey)
                                  .where("deleted", isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Center(child: Text("Loading..."));
                                return buildUsersList(snapshot);
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    filterByUser = !filterByUser;
                  });
                },
                tooltip: "Users List",
                backgroundColor: Colors.green,
                child: Icon(
                  !filterByUser ? Icons.people : Icons.list_alt,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void convertToCSV() {
    print("Floating action button clicked! Start conversion");

    // QueryDocumentSnapshot docSnap = FirebaseFirestore.instance.collection(App.kCervicalKey).where("deleted", isEqualTo: false).limit(1).snapshots().first.whenComplete(() => null);

    SurveyStorage storage = SurveyStorage(App.kBreastKey);

    List<Survey> surveys;

    print("Processing... ");
    Future<QuerySnapshot> surveysSnapshot = FirebaseFirestore.instance
        .collection(App.kBreastKey)
        .where("deleted", isEqualTo: false)
        .get()
        .then((value) {
      print("Still processing... ");
      surveys =
          value.docs.map<Survey>((snap) => Survey.fromSnapshot(snap)).toList();

      print("The length of the survey is ${surveys.length}");

      storage.writeSurvey(surveys);

      print("Done");

      return value;
    });
  }

  Widget buildSurveyList({AsyncSnapshot<QuerySnapshot> snapshot, query}) {
    return PaginateFirestore(
      //item builder type is compulsory.
      itemBuilderType: PaginateBuilderType.listView, //Change types accordingly
      itemBuilder: (index, context, documentSnapshot) => SurveyListItem(
        doc: documentSnapshot,
        index: index,
      ),
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance.collection('users').orderBy('name'),
      // to fetch real-time data
      isLive: true,
    );
  }

  ListView buildUsersList(AsyncSnapshot<QuerySnapshot> snapshot) {
    Map<String, Registerer> registers = {};
    for (QueryDocumentSnapshot doc in snapshot.data.docs) {
      Survey survey = Survey.fromSnapshot(doc);
      if (!registers.containsKey(survey.userId))
        registers[survey.userId] = Registerer(
            email: survey.userId,
            userDetails: survey.userDetail,
            surveyCount: 1);
      else
        registers[survey.userId].incrementSurveyCount();
    }

    return ListView.builder(
        // itemExtent: 110.0,
        padding: EdgeInsets.only(bottom: 40, right: 8, left: 8),
        itemCount: registers.values.length,
        itemBuilder: (context, index) => UserListItem(
            survey: registers.values.elementAt(index), index: index));
  }
}
