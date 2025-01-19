import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/api/common/execute_api_method.dart';
import 'package:quize_app/src/domain/entities/subject_entity.dart';
import '../../domain/repositories/subject_repository.dart';
import '../data_source/online_data_source/subject_online_data_source/subject_online_data_source.dart';
import '../mappers/subject_mapper.dart';

@Injectable(as: SubjectRepository)
class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectOnlineDataSource subjectOnlineDataSource;
  final SubjectMapper subjectMapper;
  SubjectRepositoryImpl(this.subjectMapper,
      {required this.subjectOnlineDataSource});
  @override
  Future<Result<List<SubjectEntity>>> getAllSubject() async {
    return executeApi<List<SubjectEntity>>(
      apiCall: () async {
        var subjectResponseModel =
            await subjectOnlineDataSource.getAllSubject();
        var subjectList = subjectMapper.toSubjectEntity(subjectResponseModel);
        return subjectList;
      },
    );
  }
}
