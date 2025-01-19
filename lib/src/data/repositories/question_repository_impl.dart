import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/api/common/execute_api_method.dart';
import 'package:quize_app/src/data/data_source/online_data_source/question_online_data_source/question_online_data_source.dart';
import 'package:quize_app/src/data/mappers/question_mapper.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';
import '../../domain/repositories/question_repository.dart';

@Injectable(as: QuestionRepository)
class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionOnlineDataSource questionOnlineDataSource;
  final QuestionMapper questionMapper;
  QuestionRepositoryImpl(
      {required this.questionOnlineDataSource, required this.questionMapper});
  @override
  Future<Result<List<QuestionEntity>>> getAllQuestionOnExamById(
      {
        required String examId}) async {
    return executeApi<List<QuestionEntity>>(
      apiCall: () async {
        var questionResponseModel = await questionOnlineDataSource
            .getAllQuestionOnExamById(examId: examId);
        return questionMapper.toListQuestionEntity(questionResponseModel);
      },
    );
  }
}
