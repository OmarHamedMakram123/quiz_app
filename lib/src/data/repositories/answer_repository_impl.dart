import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/api/common/execute_api_method.dart';
import 'package:quize_app/src/data/data_source/online_data_source/answer_data_source/answer_online_data_source.dart';
import 'package:quize_app/src/data/mappers/answer_mapper.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/domain/entities/check_question_entity.dart';
import 'package:quize_app/src/domain/repositories/answer_repository.dart';

@Injectable(as: AnswerRepository)
class AnswerRepositoryImpl implements AnswerRepository{
  final AnswerOnlineDataSource answerOnlineDataSource;
  final AnswerMapper answerMapper;

  AnswerRepositoryImpl({required this.answerOnlineDataSource, required this.answerMapper});

  @override
  Future<Result<CheckQuestionEntity>> checkAnswer({required CheckAnswerRequest checkAnswerRequest})async {
   return executeApi<CheckQuestionEntity>(apiCall: () async{
     var checkAnswerResponseModel= await answerOnlineDataSource.checkAnswerQuestion(checkAnswerRequest: checkAnswerRequest);
     return answerMapper.toCheckQuestion(checkAnswerResponseModel);
   },);
  }
}