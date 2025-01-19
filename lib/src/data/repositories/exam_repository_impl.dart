import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/api/common/execute_api_method.dart';
import 'package:quize_app/src/data/data_source/online_data_source/exam_online_data_source/exam_online_data_source.dart';
import 'package:quize_app/src/data/mappers/exam_mapper.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import '../../domain/repositories/exam_repository.dart';

@Injectable(as: ExamRepository)
class ExamRepositoryImpl implements ExamRepository {
  final ExamOnlineDataSource examOnlineDataSource;
  final ExamMapper examMapper;
  ExamRepositoryImpl(
      {required this.examOnlineDataSource, required this.examMapper});
  @override
  Future<Result<List<ExamEntity>>> getExamOnSubject(
      {required String subjectId}) async {
    return executeApi<List<ExamEntity>>(
      apiCall: () async {
        var examResponseModel =
            await examOnlineDataSource.getExamOnSubjectId(subjectId: subjectId);
        return examMapper.toExamEntity(examResponseModel);
      },
    );
  }
}
