import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../data/model/request/check_answer_request.dart';
import '../../repositories/result_repository.dart';

@injectable
class GetCachedAnswerUseCase {
  final ResultRepository resultRepository;
  GetCachedAnswerUseCase({required this.resultRepository});
  Future<Result<List<List<Answers>>>>  invoke() {
    return resultRepository.getCachedAnswer();
  }
}