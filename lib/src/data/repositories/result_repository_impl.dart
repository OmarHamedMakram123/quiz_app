import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/api/common/execute_api_method.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/answer_offline_data_source/answer_offline_data_source.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/exam_offline_data_source/exam_offline_data_source.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/qestion_offline_data_source/question_offline_data_source.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';

import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';

import '../../domain/repositories/result_repository.dart';

@Injectable(as: ResultRepository)
class ResultRepositoryImpl implements ResultRepository {
  final ExamOfflineDataSource examOfflineDataSource;
  final AnswerOfflineDataSource answerOfflineDataSource;
  final QuestionOfflineDataSource questionOfflineDataSource;
  ResultRepositoryImpl(
      this.answerOfflineDataSource, this.questionOfflineDataSource,
      {required this.examOfflineDataSource});
  @override
  Future<Result<void>> cachedExam({required ExamEntity examEntity}) async {
    return executeApi<void>(
      apiCall: () async =>
          examOfflineDataSource.cachedExam(examEntity: examEntity),
    );
  }

  @override
  Future<Result<List<ExamEntity>>> getCachedExam() async {
    return executeApi<List<ExamEntity>>(
      apiCall: () async => examOfflineDataSource.getCachedExam(),
    );
  }

  @override
  Future<Result<void>> cachedAnswer({required List<Answers> answers}) {
    return executeApi<void>(
      apiCall: () async =>
          answerOfflineDataSource.cachedAnswer(answers: answers),
    );
  }

  @override
  Future<Result<void>> cachedQuestion(
      {required List<QuestionEntity> questionEntity}) {
    return executeApi<void>(
      apiCall: () async => questionOfflineDataSource.cachedQuestion(
          questionEntity: questionEntity),
    );
  }

  @override
  Future<Result<List<List<Answers>>>> getCachedAnswer() {
    return executeApi<List<List<Answers>>>(
      apiCall: () async => answerOfflineDataSource.getCachedAnswer(),
    );
  }

  @override
  Future<Result<List<List<QuestionEntity>>>> getCachedQuestion() {
    return executeApi<List<List<QuestionEntity>>>(
      apiCall: () async => questionOfflineDataSource.getCachedQuestion(),
    );
  }
}
