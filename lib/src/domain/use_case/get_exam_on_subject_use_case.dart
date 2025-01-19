import 'package:injectable/injectable.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import '../../../core/api/common/api_result.dart';
import '../repositories/exam_repository.dart';

@injectable
class GetExamOnSubjectUseCase{
 final ExamRepository examRepository;
  GetExamOnSubjectUseCase({required this.examRepository});
  Future<Result<List<ExamEntity>>>invoke({required String subjectId }){
    return examRepository.getExamOnSubject(subjectId: subjectId);
  }
}