import 'package:breastcervicalcancersurvey_app/src/models/survey.dart';

import 'question_model.dart';

class BreastCancerSurvey extends Survey {
  String surveyId;
  String timeStamp;
  String userId;
  int answeredQuestionsCount = 0;

  BreastCancerSurvey(this.userId) {
    var currentTime = DateTime.now();
    this.timeStamp = currentTime.toString();
    this.surveyId = currentTime.millisecondsSinceEpoch.toString();
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
        questionId: "Section_B-Knowledge of Breast Cancer",
        question: "",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q1",
        question: "Have you ever heard of breast cancer?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q2.1",
        question: "What do you think is/are the cause(s) of breast cancer?",
        type: QuestionType.german,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q2.2",
        question: "Can you state another cause(s) of breast cancer?",
        type: QuestionType.german,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q2.3",
        question: "Can you state another cause(s) of breast cancer?",
        type: QuestionType.german,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q3.1",
        question:
            "Do you know if Lump or swelling in the armpit is a sign of breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q3.2",
        question:
            "Do you know if Swelling of all or parts of the breast is a sign of breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q3.3",
        question:
            "Do you know if Skin irritation or dimpling is a sign of breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q3.4",
        question:
            " Do you know if Breast or nipple pain  is a sign of breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q3.5",
        question:
            "Do you know if Nipple retraction (turning inward) is a sign of breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q3.6",
        question:
            "Do you know if Redness, scaliness, or thickening of the nipple or breast skin is a sign of breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q3.7",
        question:
            "Do you know if Nipple discharge (other than breast milk) is a sign of breast cancer ",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't know"],
        answers: []),
    Question(
        questionId: "Section_B-q4",
        question:
            "Conditions (risk factors) that determine developing breast cancer",
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q4.1",
        question:
            "Do you think being a woman is a risk factor For developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.2",
        question:
            "Do you think Getting older is a risk factor For developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.3",
        question:
            "Do you think Starting menstruation early (early menarche) is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.4",
        question:
            "Do you think Stopping menstruation late( Late menopause) is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.5",
        question:
            "Do you think Use of Oral Contraceptive Pills is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.6",
        question:
            "Do you think Having a family history of breast cancer is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.7",
        question:
            "Do you think Poor eating habit; too much fatty foods is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.8",
        question:
            "Do you think Excessive alcohol intake is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.9",
        question:
            "Do you think Being Overweight is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q4.10",
        question:
            "Do you think Sedentary lifestyle; Not exercising   is a risk factor for developing breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q5",
        question: "Have you ever heard of ways of detecting breast cancer?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q6",
        question: " If yes, mention one way breast cancer is detected. ?",
        type: QuestionType.german,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q7",
        question: "Have you ever heard of Breast Self examination (BSE)?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q8",
        question: "Have you ever heard of Clinical Breast examination (CBE)?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q9",
        question: "Have you ever heard of mammography?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q10",
        question:
            'Ways breast cancer can be treated. \nTick (    ) “Yes” each way you know breast cancer can be treated, “No” if it cannot be used to treat breast cancer and “Don’t know” if you have no idea.',
        type: QuestionType.leadQuestion,
        options: [],
        answers: []),
    Question(
        questionId: "Section_B-q10.1",
        question: "Do you know if breast cancer can be treated by Lab tests",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.2",
        question:
            "Do you know if breast cancer can be treated by Surgery (removal of breast)",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.3",
        question:
            "Do you know if breast cancer can be treated by Use of drugs (chemotherapy)",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.4",
        question:
            " Do you know if breast cancer can be treated by Use of radiation (radiotherapy) ",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.5",
        question:
            "Do you know if breast cancer can be treated by Use of herbs ",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.6",
        question:
            " Do you know if breast cancer can be treated by Use of anointing oil ",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.7",
        question:
            "Do you know if breast cancer can be treated by Use of spiritual oil ",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.8",
        question:
            "Do you know if breast cancer can be treated by Use of magic powder,",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q10.9",
        question:
            "Do you know if breast cancer can be treated by making sacrification marks on the breast ",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_B-q11",
        question: ". Do you know someone who has/had breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q12",
        question: " If YES, what is your relationship with such person?",
        type: QuestionType.multiChoice,
        options: [
          "Nuclear relative",
          "Extended relative",
          "Friend ",
          "Others "
        ],
        answers: []),
    Question(
        questionId: "Section_B-q13",
        question: " Do you know someone who died of breast cancer",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q14",
        question: "If YES, what is your relationship with such person?",
        type: QuestionType.multiChoice,
        options: [
          "Nuclear relative",
          "Extended relative",
          "Friend ",
          "Others "
        ],
        answers: []),
    Question(
        questionId: "Section_B-q15",
        question:
            "Do you consider any changes in the breast (e.g lump, swelling, discharge from the nipples) a form of spiritual attack?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No"],
        answers: []),
    Question(
        questionId: "Section_B-q16",
        question:
            "What will be your first thought if a woman comes to tell you she has discovered a lump in her breast?",
        type: QuestionType.multiChoice,
        options: [
          "It could be a spiritual attack",
          "It could be breast cancer",
          "It is just a regular boil",
          "It is nothing to be worried about",
        ],
        answers: []),
    Question(
        questionId: "Section_C-q1.1",
        question: " Lump in the breast is not an issue to worry about",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_C-q1.2",
        question: ",Breast cancer is in most cases a spiritual attack",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_C-q1.3",
        question:
            "Prayer is more necessary in addressing unexplained lump in the breast than seeking medical help.",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          " Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_C-q1.4",
        question: "Breast cancer happens to only those who lack faith  in God ",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          "Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_C-q1.5",
        question:
            "Those who spend quality time in the place of prayer will not die of breast cancer even if they do not seek medical attention.  ",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          "Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_C-q1.6",
        question:
            "Breast cancer is not something that is associated with religious people",
        type: QuestionType.multiChoice,
        options: [
          "Agree",
          "Disagree",
          "Not sure",
        ],
        answers: []),
    Question(
        questionId: "Section_C-q2",
        question:
            "Do you think it is possible for any woman (including you) to develop breast cancer in your lifetime?",
        type: QuestionType.multiChoice,
        options: ["Yes", "No", "Don't Know"],
        answers: []),
    Question(
        questionId: "Section_C-q3",
        question:
            "If No, Why do you think it is not possible for any woman (including you) to develop breast cancer in her lifetime",
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
        questionId: "Section_C-q4",
        question:
            "If Yes, Why do you think it is possible for any woman (including you) to develop breast cancer in her lifetime",
        type: QuestionType.multipleSelection,
        options: [
          "I just guess",
          "Family history",
          "Because of age",
          "Because it can happen to any woman",
          "Others (Specify)  _______",
        ],
        answers: []),
  ];
}
