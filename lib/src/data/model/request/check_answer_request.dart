import 'package:quize_app/src/domain/entities/subject_entity.dart';

import '../../../domain/entities/exam_entity.dart';

class CheckAnswerRequest {
  CheckAnswerRequest({this.subjectEntity,this.answers, this.time, required this.examEntity});

  List<Answers>? answers;
  num? time;
  ExamEntity examEntity;
  SubjectEntity? subjectEntity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (answers != null) {
      map['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    map['time'] = time;
    return map;
  }
}

class Answers {
  Answers(
      {this.questionId,
      this.correct,
      this.currentIndexOptionSelection,
      this.answerKey,});

  String? questionId;
  String? correct;
  String? answerKey;
  int? currentIndexOptionSelection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = questionId;
    map['correct'] = answerKey;
    return map;
  }
}
