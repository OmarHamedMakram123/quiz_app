import 'package:injectable/injectable.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/repositories/result_repository.dart';

import '../../../../core/api/common/api_result.dart';

@injectable
class GetCachedExamUseCase {
  final ResultRepository resultRepository;
  GetCachedExamUseCase({required this.resultRepository});
  Future<Result<List<ExamEntity>>>invoke(){
     return resultRepository.getCachedExam();
  }

}