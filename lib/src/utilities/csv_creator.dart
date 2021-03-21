import 'dart:async';
import 'dart:io';

import 'package:breastcervicalcancersurvey_app/apptheme.dart';
import 'package:breastcervicalcancersurvey_app/src/models/question_model.dart';
import 'package:breastcervicalcancersurvey_app/src/models/survey.dart';
import 'package:path_provider/path_provider.dart';

class SurveyStorage {
  String surveyKey = '';
  String _surveyName;

  SurveyStorage(this.surveyKey) {
    _surveyName = surveyKey != App.kBreastKey
        ? "Cervical Cancer Survey"
        : "Breast Cancer Survey";
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_surveyName.csv');
  }

  Future<void> writeTableHeaders(sink, Survey survey) async {
    sink.write(
        '"Survey Id","TimeStamp","User Email","User Details","Answered Questions Count",');
    for (Question q in survey.surveyQuestions) {
      sink.write('"${q.question}",');
    }
    sink.write("\n");

    return null;
  }

  Future<File> writeSurvey(List<Survey> surveys) async {
    final file = await _localFile;
    var sink = file.openWrite();

    print(file.path);

    writeTableHeaders(sink, surveys[0]);

    for (Survey survey in surveys) {
      sink.write(
          '"${survey.surveyId}","${survey.timeStamp}","${survey.userId}","${survey.userDetail}","${survey.answeredQuestionsCount}",');

      for (Question q in survey.surveyQuestions) {
        sink.write('"${q.answers.toString()}",');
      }

      sink.write("\n");
      // Close the IOSink to free system resources.
    }
    sink.close();

    return file;
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
}
