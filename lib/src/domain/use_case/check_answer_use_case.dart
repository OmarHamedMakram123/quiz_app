import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/domain/entities/check_question_entity.dart';
import 'package:quize_app/src/domain/repositories/answer_repository.dart';
import '../../data/model/request/check_answer_request.dart';

@injectable
class CheckAnswerUseCase {
  final AnswerRepository answerRepository;
  CheckAnswerUseCase({required this.answerRepository});
  Future<Result<CheckQuestionEntity>> invoke(
      {required CheckAnswerRequest checkAnswerRequest}) {
    return answerRepository.checkAnswer(checkAnswerRequest: checkAnswerRequest);
  }
}
