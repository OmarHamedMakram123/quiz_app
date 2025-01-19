import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';
import 'package:quize_app/src/domain/repositories/result_repository.dart';

@injectable
class CachedQuestionUseCase {
  final ResultRepository resultRepository;
  CachedQuestionUseCase({required this.resultRepository});
  Future<Result<void>>invoke({required List<QuestionEntity> questions}){
    return resultRepository.cachedQuestion(questionEntity: questions);
  }

}