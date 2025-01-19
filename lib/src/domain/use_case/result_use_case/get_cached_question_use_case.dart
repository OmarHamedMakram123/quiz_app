import 'package:injectable/injectable.dart';

import '../../../../core/api/common/api_result.dart';
import '../../entities/question_entity.dart';
import '../../repositories/result_repository.dart';

@injectable
class GetCachedQuestionUseCase {
  final ResultRepository resultRepository;
  GetCachedQuestionUseCase({required this.resultRepository});
  Future<Result<List<List<QuestionEntity>>>> invoke() {
    return resultRepository.getCachedQuestion();
  }
}
