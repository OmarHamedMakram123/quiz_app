import 'package:quize_app/src/domain/entities/subject_entity.dart';
import '../../../core/api/common/api_result.dart';

abstract class SubjectRepository{
  Future<Result<List<SubjectEntity>>>getAllSubject();
}