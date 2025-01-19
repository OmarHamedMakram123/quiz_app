import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';

sealed class ResultAction {}

class CachedListExamAction extends ResultAction{
 final  ExamEntity examsEntity;
  CachedListExamAction({required this.examsEntity});
}
class GetCachedExamAction extends ResultAction{}
class GetCachedQuestionAction extends ResultAction{}
class GetCachedAnswerAction extends ResultAction{}

class CachedListQuestionAction extends ResultAction{
 final List<QuestionEntity>questions;
  CachedListQuestionAction({required this.questions});
}
class CachedListAnswerAction extends ResultAction{
 final List<Answers> answers;
  CachedListAnswerAction({required this.answers});
}
