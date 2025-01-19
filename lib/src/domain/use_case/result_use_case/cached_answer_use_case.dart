import 'package:injectable/injectable.dart';
import 'package:quize_app/src/domain/repositories/result_repository.dart';

import '../../../../core/api/common/api_result.dart';
import '../../../data/model/request/check_answer_request.dart';

@injectable
class CachedAnswerUseCase {
  final ResultRepository resultRepository;
  CachedAnswerUseCase({required this.resultRepository});
  Future<Result<void>> invoke({required List<Answers> answer}) {
    return resultRepository.cachedAnswer(answers: answer);
  }
}
