
import 'package:quize_app/src/domain/entities/question_entity.dart';

import '../../../core/api/common/api_result.dart';

abstract class QuestionRepository{
  Future<Result<List<QuestionEntity>>> getAllQuestionOnExamById({required String examId});
}