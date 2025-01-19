import 'package:injectable/injectable.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/model/question/cache_model/question_cache_model.dart';
import 'package:quize_app/src/data/model/response/question_response_model/question_response_model.dart';
import 'package:quize_app/src/domain/entities/answer_entity.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';
import 'package:quize_app/src/domain/entities/subject_entity.dart';

abstract class QuestionMapper {
  List<QuestionEntity> toListQuestionEntity(
      QuestionResponseModel questionResponseModel);
  List<QuestionCacheModel> toListQuestionCachedModel(
      List<QuestionEntity> questionEntity);
  List<List<QuestionEntity>>  toListQuestionEntityCached(
      List<List<QuestionCacheModel>> questionCachedModel);
}

@Injectable(as: QuestionMapper)
class QuestionMapperImpl implements QuestionMapper {
  @override
  List<QuestionEntity> toListQuestionEntity(
      QuestionResponseModel questionResponseModel) {
    if (questionResponseModel.questions == null) return [];
    List<QuestionEntity> questions = questionResponseModel.questions!
        .map(
          (questions) => _toQuestion(questions),
        )
        .toList();
    return questions;
  }
  QuestionEntity _toQuestion(Questions question) {
    return QuestionEntity(
        answer: _toListAnswersEntity(question.answers ?? []),
        examId: question.exam?.Id,
        questionId: question.Id,
        numberOfQuestions: question.exam?.numberOfQuestions,
        duration: question.exam?.duration,
        title: question.question,
        correct: question.correct,
        subjectEntity: _toSubjectEntity(question.subject));
  }
  List<AnswerEntity> _toListAnswersEntity(List<Answers> answers) {
    return answers
        .map(
          (answer) => _toAnswerEntity(answer),
        )
        .toList();
  }
  AnswerEntity _toAnswerEntity(Answers answer) {
    return AnswerEntity(answer: answer.answer, key: answer.key);
  }
  SubjectEntity _toSubjectEntity(Subject? subject) {
    return SubjectEntity(
        id: subject?.Id, name: subject?.name, iconImage: subject?.icon);
  }



  @override
  List<QuestionCacheModel> toListQuestionCachedModel(
      List<QuestionEntity> questionEntity) {
    if (questionEntity.isEmpty) return [];
    return questionEntity
        .map(
          (e) => _toQuestionCachedModel(e),
        )
        .toList();
  }

  QuestionCacheModel _toQuestionCachedModel(QuestionEntity questionEntity) {
    return QuestionCacheModel(
        answer: _toListAnswerCachedModel(questionEntity.answer ?? []),
        title: questionEntity.title,
        numberOfQuestions: questionEntity.numberOfQuestions,
        duration: questionEntity.duration,
        questionId: questionEntity.questionId,
        examId: questionEntity.examId);
  }

  List<AnswerCachedModel> _toListAnswerCachedModel(List<AnswerEntity> answer) {
    if (answer.isEmpty) return [];
    return answer
        .map(
          (e) => _toAnswerCachedModel(e),
        )
        .toList();
  }

  AnswerCachedModel _toAnswerCachedModel(AnswerEntity answerEntity) {
    return AnswerCachedModel(
        answer: answerEntity.answer, key: answerEntity.key);
  }




  @override
  List<List<QuestionEntity>> toListQuestionEntityCached(List<List<QuestionCacheModel>> questionsCachedModel) {
    return  questionsCachedModel.map((e) => _toListQuestionEntityCached(e),).toList();
  }

  @override
  List<QuestionEntity> _toListQuestionEntityCached(
      List<QuestionCacheModel> questionCachedModel) {
    if (questionCachedModel.isEmpty) return [];
    return questionCachedModel
        .map(
          (e) => _toQuestionCachedEntity(e),
        )
        .toList();
  }

  QuestionEntity _toQuestionCachedEntity(QuestionCacheModel questionModel) {
    return QuestionEntity(
        answer: _toListAnswerCachedEntity(questionModel.answer ?? []),
        title: questionModel.title,
        numberOfQuestions: questionModel.numberOfQuestions,
        duration: questionModel.duration,
        questionId: questionModel.questionId,
        examId: questionModel.examId);
  }

  List<AnswerEntity> _toListAnswerCachedEntity(List<AnswerCachedModel> answer) {
    if (answer.isEmpty) return [];
    return answer
        .map(
          (e) => _toAnswerCachedEntity(e),
        )
        .toList();
  }

  AnswerEntity _toAnswerCachedEntity(AnswerCachedModel answerCachedModel) {
    return AnswerEntity(
        answer: answerCachedModel.answer, key: answerCachedModel.key);
  }





}
