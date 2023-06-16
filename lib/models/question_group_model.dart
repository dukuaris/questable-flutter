import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionGroupModel {
  List<MultipleChoice>? questions;
  String? category;
  String? type;
  String? imgUrl;
  String? createdAt;
  String userId;
  String subject;
  String source;
  int? unit;
  int? score;
  int timeSeconds;
  String? id;

  QuestionGroupModel(
      {this.questions,
      this.category,
      this.type,
      this.imgUrl,
      this.createdAt,
      required this.userId,
      required this.subject,
      required this.source,
      this.unit,
      this.score,
      required this.timeSeconds,
      this.id});

  QuestionGroupModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        subject = json['subject'],
        source = json['source'],
        unit = json['unit'],
        score = json['score'],
        timeSeconds = json['timeSeconds'],
        questions = (json['questions'] as List)
            .map((e) => MultipleChoice.fromJson(e))
            .toList(),
        category = json['category'],
        type = json['type'],
        imgUrl = json['imgUrl'],
        createdAt = json['createdAt'],
        id = json['id'];

  QuestionGroupModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : userId = snapshot['userId'],
        subject = snapshot['subject'],
        source = snapshot['source'],
        unit = snapshot['unit'],
        timeSeconds = snapshot['timeSeconds'],
        category = snapshot['category'],
        type = snapshot['type'],
        imgUrl = snapshot['imgUrl'],
        createdAt = snapshot['createdAt'].toString(),
        id = snapshot.id;

  String timeInMinutes() => "${(timeSeconds! / 60).ceil()} mins";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    data['subject'] = this.subject;
    data['source'] = this.source;
    data['unit'] = this.unit;
    data['score'] = this.score;
    data['id'] = this.id;
    return data;
  }
}

class MultipleChoice {
  String? category;
  String? createdAt;
  String? difficulty;
  String question;
  String correctAnswer;
  List<String>? questionGroup;
  String userId;
  int? score;
  List<String> incorrectAnswers;
  String? subject;
  int? play;
  String? updatedAt;
  String type;
  String? id;
  String? selectedAnswer;
  List<String> answers = [];

  MultipleChoice({
    this.category,
    this.createdAt,
    this.difficulty,
    required this.question,
    required this.correctAnswer,
    this.questionGroup,
    required this.userId,
    this.score,
    required this.incorrectAnswers,
    this.subject,
    this.play,
    this.updatedAt,
    required this.type,
    this.id,
    this.selectedAnswer,
    required this.answers,
  });

  MultipleChoice.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        createdAt = (json['createdAt'] as Timestamp).toDate().toString(),
        difficulty = json['difficulty'],
        question = json['question'],
        correctAnswer = json['correct_answer'],
        questionGroup = json['questionGroup'].cast<String>(),
        userId = json['userId'],
        score = json['score'],
        incorrectAnswers = json['incorrect_answers'].cast<String>(),
        subject = json['subject'],
        play = json['play'],
        updatedAt = (json['updatedAt'] as Timestamp).toDate().toString(),
        type = json['type'],
        id = json['id'];

  MultipleChoice.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : category = snapshot['category'],
        difficulty = snapshot['difficulty'],
        question = snapshot['question'],
        correctAnswer = snapshot['correctAnswer'],
        questionGroup = snapshot['questionGroup'].cast<String>(),
        userId = snapshot['userId'],
        score = snapshot['score'],
        incorrectAnswers = snapshot['incorrectAnswers'].cast<String>(),
        subject = snapshot['subject'],
        play = snapshot['play'],
        createdAt = (snapshot['createdAt'] as Timestamp).toDate().toString(),
        updatedAt = (snapshot['updatedAt'] as Timestamp).toDate().toString(),
        type = snapshot['type'],
        id = snapshot.id,
        answers = [
          snapshot['correctAnswer'],
          ...snapshot['incorrectAnswers'].cast<String>()
        ]..shuffle();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['difficulty'] = this.difficulty;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['questionGroup'] = this.questionGroup;
    data['userId'] = this.userId;
    data['score'] = this.score;
    data['incorrect_answers'] = this.incorrectAnswers;
    data['subject'] = this.subject;
    data['play'] = this.play;
    data['updatedAt'] = this.updatedAt;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}
