import 'package:injectable/injectable.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/repositories/result_repository.dart';

import '../../../../core/api/common/api_result.dart';

@injectable
class CachedExamUseCase {
  final ResultRepository resultRepository;
  CachedExamUseCase({required this.resultRepository});
  Future<Result<void>>invoke({required ExamEntity examEntity}){
    return resultRepository.cachedExam(examEntity: examEntity);
  }

}