import 'package:injectable/injectable.dart';
import 'package:quize_app/src/domain/entities/subject_entity.dart';
import '../../../core/api/common/api_result.dart';
import '../repositories/subject_repository.dart';

@injectable
class GetAllSubjectUseCase{
  final SubjectRepository subjectRepository;
  GetAllSubjectUseCase({required this.subjectRepository});

  Future<Result<List<SubjectEntity>>>invoke()
  {
    return subjectRepository.getAllSubject();
  }
}