import 'package:breastcervicalcancersurvey_app/src/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Survey {
  String surveyId;
  List<Question> surveyQuestions;
  String timeStamp;
  int answeredQuestionsCount = 0;
  String userId;
  bool deleted = false;
  String userDetail;

  Survey() {}

  Survey.fromSnapshot(QueryDocumentSnapshot snap) {
    surveyId = snap.id;
    timeStamp = snap.data()["timeStamp"] ?? surveyId;
    userId = snap.get("userId");
    surveyQuestions = snap
        .get('surveyQuestions')
        .map<Question>((p) => Question.fromMap(p))
        .toList(); // map product array to list
    answeredQuestionsCount =
        snap.data()["answeredQuestionsCount"] ?? _getAnswered();
    deleted = snap.get("deleted");
    userDetail = snap.data()["userDetail"];
  }

  Survey.fromMap(Map<String, dynamic> data) {
    surveyId = data['surveyId'];
    timeStamp = data['timeStamp'] ?? surveyId;
    surveyQuestions = data["surveyQuestions"];
    userId = data["userId"];
    deleted = data["deleted"];
    userDetail = data["userDetail"];
    answeredQuestionsCount = data["answeredQuestionsCount"] ?? _getAnswered();
  }

  Map<String, dynamic> toMap() {
    return {
      'surveyId': surveyId,
      'answeredQuestionsCount': answeredQuestionsCount,
      'timeStamp': timeStamp,
      'userId': userId,
      'deleted': deleted,
      'userDetail': userDetail,
      // 'name':name,
      'surveyQuestions':
          surveyQuestions.map((i) => i.toMap()).toList(), // this worked well
    };
  }

  void calculateAnswered() {
    int count = 0;
    if (surveyQuestions == null || surveyQuestions.length == 0) return;
    for (Question question in surveyQuestions)
      if (question.type != QuestionType.leadQuestion && question.answered)
        count++;
    answeredQuestionsCount = count;
  }

  int _getAnswered() {
    calculateAnswered();
    return answeredQuestionsCount;
  }

  int getTotalQuestions() {
    int count = 0;
    for (Question q in surveyQuestions) {
      if (q.type != QuestionType.leadQuestion) count++;
    }
    return count;
  }
}
