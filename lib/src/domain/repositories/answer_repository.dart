
import 'package:quize_app/src/data/model/request/check_answer_request.dart';

import '../../../core/api/common/api_result.dart';
import '../entities/check_question_entity.dart';

abstract class AnswerRepository{
  Future<Result<CheckQuestionEntity>> checkAnswer({
    required CheckAnswerRequest checkAnswerRequest
});
}