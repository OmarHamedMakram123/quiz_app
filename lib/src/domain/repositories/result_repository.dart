import 'package:quize_app/core/api/common/api_result.dart';

import '../../data/model/request/check_answer_request.dart';
import '../entities/exam_entity.dart';
import '../entities/question_entity.dart';

abstract class ResultRepository {
  Future<Result<List<ExamEntity>>> getCachedExam();
  Future<Result<void>> cachedExam({required ExamEntity examEntity});
  Future<Result<void>> cachedQuestion({required List<QuestionEntity> questionEntity});
  Future<Result<List<List<QuestionEntity>>>>getCachedQuestion();
  Future<Result<void>>cachedAnswer({required List<Answers> answers});
  Future<Result<List<List<Answers>>>>getCachedAnswer();
}