import 'package:breastcervicalcancersurvey_app/src/models/survey.dart';

import 'question_model.dart';

class CervicalCancerSurvey extends Survey {
  String surveyId;
  String timeStamp;
  String userId;
  int answeredQuestionsCount = 0;

  CervicalCancerSurvey(this.userId) {
    DateTime currentTime = DateTime.now();
    timeStamp = currentTime.toString();
    surveyId = currentTime.millisecondsSinceEpoch.toString();
  }

  List<Question> surveyQuestions = [
    Question(
        questionId: "Section_A-q1",
        question: "Employment Status of respondent:",
        type: QuestionType.multiChoice,
        options: [
          "Housewife",
          "Self-employed",
          "Employed",
          "Unemployed",
          "Student",
        ],
        answers: []),
    Question(
        questionId: "Section_A-q2",
        question: "How old are you now? ",
        type: QuestionType.german,
        options: [],
        answers: []),
    Question(
        questionId: "Section_A-q3",
        question: "What is you marital status? ",
        type: QuestionType.multiChoice,
        options: [
          "Single",
          "Married",
          "Separated",
          "Divorced",
          "Widowed/Widower"
        ],
        answers: []),
    Question(
        questionId: "Section_A-q4",
        question: "Local government area of residence?",
        type: QuestionType.multiChoice,
        options: [
          "Akoko North-West",
          "Akoko South-West",
          "Akoko South-East",
          "Akoko North-East",
          "Akure North",
          "Akure South",
          "Ese Odo",
          "Idanre",
          "Ifedore",
          "Ilaje",
          "Ile Oluji/Okeigbo",
          "Irele",
          "Odigbo",
          "Okitipupa",
          "Ondo East",
          "Ondo West",
          "Ose",
          "Owo",
        ],
        answers: []),
    Question(
        questionId: "Section_A-q5",
        question: "Highest level of education attained?",
        type: QuestionType.multiChoice,
        options: ["No Formal education", "Primary", "Secondary", "Tertiary"],
        answers: []),
    Question(
        questionId: "Section_A-q6",
        question: "What is your ethnic group?",
        type: QuestionType.multiChoice,
        options: ["Yoruba", "Igbo", "Hausa", "Others"],
        answers: []),
    Question(
        questionId: "Section_A-q7",
        question: "How much do you earn weekly",
        type: QuestionType.multiChoice,
        options: [
          "0 – 1000",
          "1000 – 5000",
          "5000 – 10000",
          "10000 – 20000",
          "20000 and above",
        ],
        answers: []),
    Question(
        questionId: "Section_A-q8",
        question: "What is your religion",
        type: QuestionType.multiChoice,
        options: [
          "Christian",
          "Muslim",
          "Traditional",
          "No Religion",
          "Others (Specify) _______",
        ],
        answers: []),
    Question(
        questionId: "Section_B-About",
        question: "Knowledge of cervical cancer",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q1",
        question: "Have you ever heard of cervical cancer?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q2",
        question: "What do you think is the cause of cervical cancer?",
        type: QuestionType.german,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q3",
        question: "Have you ever heard of human papilloma virus (HPV)",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q4",
        question: "Is cervical cancer preventable?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q5",
        question: "Is having many different sexual partners a risk factor?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q6",
        question: "Is smoking a risk factor for cervical cancer?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q7",
        question: "Is HIV a risk factor for cervical cancer?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q8",
        question: "Is oral contraception a risk factor for cervical cancer?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q9",
        question: "Is giving birth to many babies a risk factor?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q10",
        question:
            "Is human papilloma virus (HPV) a risk factor for cervical cancer?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q11",
        question:
            "Are you more likely to develop cervical cancer if a family member has/had it?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-Symptoms",
        question: "Symptoms of Cervical Cancer",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_C-q1.1",
        question: "Is vaginal bleeding a symptom of cervical cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-q1.2",
        question: "Is foul smelling a symptom of cervical cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-q1.3",
        question:
            "Is experiencing pain during intercourse a symptom of cervical cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-q2",
        question: "Knowledge of Screening",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_C-q2.1",
        question: "Do you know any method of screening for cervical cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-q2.1 i",
        question: "If yes, is Pap Smear a method?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-q2.1 ii",
        question: "If yes, is visual inspection of cervix a method?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-q2.1 iii",
        question: "If yes, is	human papillomavirus DNA testing a method?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_C-q2.1 iv",
        question: "If yes, is liquid-based cytology a method?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_D-q1",
        question: "Perceived seriousness",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_D-q1.1",
        question: "Unusual vaginal bleeding is not an issue to worry about",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q1.2",
        question: "Cervical cancer is in most cases a spiritual attack",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q1.3",
        question: "I don’t think cervical cancer screening is necessary",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q2",
        question: "Perceived susceptibility",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_D-q2.1",
        question: "Cervical cancer happens to only those who lack faith in God",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q2.2",
        question:
            "Those who spend quality time in the place of prayer or seek traditional help will not die of cervical cancer even if they do not seek medical attention. ",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q2.3",
        question:
            "Cervical cancer is not something that is associated with religious or traditional people",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q3",
        question:
            "Do you think it is possible for any woman (including you) to develop cervical cancer in your lifetime?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_D-q4",
        question:
            "If No, Why do you think it is not possible for any woman (including you) to develop cervical cancer in her lifetime",
        type: QuestionType.multipleSelection,
        options: [
          "Because my faith in God or charms will protect me",
          "Because nobody has had it in my family",
          "Because it is not my portion",
          "No particular reason",
          "Other reasons ______",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q5",
        question:
            "If Yes, Why do you think it is possible for any woman (including you) to develop cervical cancer in her lifetime",
        type: QuestionType.multipleSelection,
        options: [
          "I just guess",
          "Family history",
          "Because of age",
          "Because it can happen to any woman",
          "Others (Specify)  _______",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q6",
        question: "Screening Acceptability",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_D-q6.1",
        question: "Have you done cervical screening test in the past?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q6.2",
        question: "If no, why have you not done cervical screening test?",
        type: QuestionType.multiChoice,
        options: [
          "Not aware of the test",
          "Never thought about it",
          "it is costly",
          "there is no time",
          "it is for married women",
          "husband not in support",
          "afraid of the result",
          "others (specify) ________",
        ],
        answers: []),
    Question(
        questionId: "Section_D-q6.1",
        question:
            "Will you like to do cervical cancer screening test if the services are available locally?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
          "Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_E-Sexual Activity",
        question: "Note: All answers are anonymous and treated confidentially",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_E-q1",
        question: "Are you sexually active?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
          "Not anymore",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q2",
        question:
            "If single, have you had sexual relationship with more than one man?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q3",
        question:
            "If married, some cultures permit premarital sexual relationships; did you have any before your marriage?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q4",
        question:
            "If married, have you had extramarital sex, that is sex with any other man apart from your husband since marriage?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q5",
        question: "Have you heard of condom?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
          "Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q6",
        question: "Do you know what condom is used for?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q4",
        question: "Do you use condom during sex?",
        type: QuestionType.multiChoice,
        options: [
          "All the time",
          "Most of the time",
          "Some of the time",
          "Rarely",
          "Not at all",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q6",
        question:
            "Women often have whitish vaginal discharge; but have you had worrisome vaginal discharge(s) that required treatment in the past?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
        ],
        answers: []),
    Question(
        questionId: "Section_E-q6.1",
        question:
            "Will you like to do cervical cancer screening test if the services are available locally?",
        type: QuestionType.multiChoice,
        options: [
          "Yes",
          "No",
          "Not sure",
        ],
        answers: []),
  ];
}
