import 'package:injectable/injectable.dart';
import 'package:quize_app/src/domain/entities/check_question_entity.dart';

import '../data_source/offline_data_source/result_offline_data_source/model/answer_cache_model/answer_cache_model.dart';
import '../model/request/check_answer_request.dart';
import '../model/response/check_answer_model/check_answer_question_model.dart';

abstract class AnswerMapper {
  CheckQuestionEntity toCheckQuestion(CheckAnswerQuestionModel checkAnswer);
  List<CheckAnswerCachedModel> toListCheckAnswerCachedModel(
      {required List<Answers> answers});
  List<List<Answers>> toListCheckAnswerEntity(
      {required List<List<CheckAnswerCachedModel>> answerModel});
}


@Injectable(as: AnswerMapper)
class AnswerMapperImpl implements AnswerMapper {
  @override
  CheckQuestionEntity toCheckQuestion(CheckAnswerQuestionModel checkAnswer) {
    return CheckQuestionEntity(
      correct: checkAnswer.correct?.toInt() ?? 0,
      wrong: checkAnswer.wrong?.toInt() ?? 0,
      total: checkAnswer.total,
      message: checkAnswer.message,
    );
  }

  @override
  List<CheckAnswerCachedModel> toListCheckAnswerCachedModel(
      {required List<Answers> answers}) {
    if (answers.isEmpty) return [];
    return answers
        .map(
          (e) => _toCheckAnswerCachedModel(e),
        )
        .toList();
  }

  CheckAnswerCachedModel _toCheckAnswerCachedModel(Answers answer) {
    return CheckAnswerCachedModel(
        questionId: answer.questionId,
        currentIndexOptionSelection: answer.currentIndexOptionSelection,
        correct: answer.correct,
        answerKey: answer.answerKey ?? "");
  }

  @override
  List<List<Answers>> toListCheckAnswerEntity(
      {required List<List<CheckAnswerCachedModel>> answerModel}) {
    if (answerModel.isEmpty) return [];
    return answerModel
        .map(
          (e) => _toListCheckAnswer(answerModel: e),
        )
        .toList();
  }

  List<Answers> _toListCheckAnswer(
      {required List<CheckAnswerCachedModel> answerModel}) {
    if (answerModel.isEmpty) return [];
    return answerModel
        .map(
          (e) => _toAnswerCachedEntity(e),
        )
        .toList();
  }

  Answers _toAnswerCachedEntity(CheckAnswerCachedModel checkAnswerCachedModel) {
    return Answers(
        correct: checkAnswerCachedModel.correct,
        currentIndexOptionSelection:
            checkAnswerCachedModel.currentIndexOptionSelection,
        questionId: checkAnswerCachedModel.questionId,
        answerKey: checkAnswerCachedModel.answerKey );
  }
}
