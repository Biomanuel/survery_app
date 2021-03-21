import 'package:breastcervicalcancersurvey_app/src/models/survey.dart';

class Registerer {
  String email;
  String userDetails;
  int surveyCount = 0;

  Registerer({this.email, this.userDetails, this.surveyCount});

  void incrementSurveyCount() {
    surveyCount++;
    // print("$email new count: $surveyCount");
  }
}
