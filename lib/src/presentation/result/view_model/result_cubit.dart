import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/error/error_handler.dart';
import 'package:quize_app/core/error/error_model.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';
import 'package:quize_app/src/domain/use_case/result_use_case/cached_answer_use_case.dart';
import 'package:quize_app/src/domain/use_case/result_use_case/cached_exam_use_case.dart';
import 'package:quize_app/src/domain/use_case/result_use_case/cached_question_use_case.dart';
import 'package:quize_app/src/domain/use_case/result_use_case/get_cached_answer_use_case.dart';
import 'package:quize_app/src/domain/use_case/result_use_case/get_cached_exam_use_case.dart';
import 'package:quize_app/src/domain/use_case/result_use_case/get_cached_question_use_case.dart';
import 'package:quize_app/src/presentation/result/view_model/result_action.dart';
part 'result_state.dart';

@injectable
class ResultCubit extends Cubit<ResultState> {
  final GetCachedExamUseCase getCachedExamUseCase;
  final CachedExamUseCase cachedExamUseCase;
  final GetCachedQuestionUseCase getCachedQuestionUseCase;
  final CachedQuestionUseCase cachedQuestionUseCase;
  final GetCachedAnswerUseCase getCachedAnswerUseCase;
  final CachedAnswerUseCase cachedAnswerUseCase;
  ResultCubit(
      this.getCachedExamUseCase,
      this.cachedExamUseCase,
      this.getCachedQuestionUseCase,
      this.cachedQuestionUseCase,
      this.getCachedAnswerUseCase,
      this.cachedAnswerUseCase)
      : super(ResultInitial());

  Future<void> doAction(ResultAction resultAction) async {
    switch (resultAction) {
      case CachedListExamAction():
        return await _cachedExam(resultAction.examsEntity);
      case GetCachedExamAction():
        return await _getCachedExam();
      case GetCachedQuestionAction():
        return await _getCachedQuestion();
      case GetCachedAnswerAction():
        return await _getCachedAnswers();
      case CachedListQuestionAction():
        return await _cachedQuestions(resultAction.questions);
      case CachedListAnswerAction():
        return await _cachedAnswer(resultAction.answers);
    }
  }

  List<ExamEntity> exams = [];
  List<List<QuestionEntity>> questions = [];
  List<List<Answers>> answers = [];
  int selectedIndex = 0;

  Future<void> _cachedExam(ExamEntity examsEntity) async {
    emit(CachedExamLoadingState());
    var result = await cachedExamUseCase.invoke(examEntity: examsEntity);
    switch (result) {
      case Success<void>():
        emit(CachedExamSuccessState());
      case Failures<void>():
        final errorModel = ErrorHandler.formException(result.exception);
        emit(CachedExamFailuresState(errorModel: errorModel));
    }
  }

  Future<void> _getCachedExam() async {
    emit(GetCachedExamsLoadingState());
    var result = await getCachedExamUseCase.invoke();
    switch (result) {
      case Success<List<ExamEntity>>():
        exams = result.date;
        emit(GetCachedSuccessState());
      case Failures<List<ExamEntity>>():
        final errorModel = ErrorHandler.formException(result.exception);
        emit(GetCachedFailuresState(errorModel: errorModel));
    }
  }



  Future<void> _cachedQuestions(List<QuestionEntity> questions) async {
    emit(CachedQuestionLoadingState());
    var result = await cachedQuestionUseCase.invoke(questions: questions);
    switch (result) {
      case Success<void>():
        emit(CachedQuestionSuccessState());
      case Failures<void>():
        final errorModel = ErrorHandler.formException(result.exception);
        emit(CachedQuestionFailuresState(errorModel: errorModel));
    }
  }

  Future<void> _getCachedQuestion() async {
    print("111111111111111");
    emit(GetCachedQuestionLoadingState());
    var result = await getCachedQuestionUseCase.invoke();
    switch (result) {
      case Success<List<List<QuestionEntity>>>():
        questions = result.date;
        emit(GetCachedQuestionSuccessState());
        print("111111111111111000000000000000");
      case Failures<List<List<QuestionEntity>>>():
        final errorModel = ErrorHandler.formException(result.exception);
        print("error Model :${errorModel.errorMassage}");
        emit(GetCachedQuestionFailuresState(errorModel: errorModel));
    }
  }




  Future<void> _cachedAnswer(List<Answers> answer) async {
    emit(CachedAnswerLoadingState());
    var result = await cachedAnswerUseCase.invoke(answer: answer);
    switch (result) {
      case Success<void>():
        emit(CachedAnswerSuccessState());
      case Failures<void>():
        final errorModel = ErrorHandler.formException(result.exception);
        emit(CachedAnswerFailuresState(errorModel: errorModel));
    }
  }

  Future<void> _getCachedAnswers() async {
    emit(GetCachedAnswerLoadingState());
    var result = await getCachedAnswerUseCase.invoke();
    switch (result) {
      case Success<List<List<Answers>>>():
        answers = result.date;
        emit(GetCachedAnswerSuccessState());
      case Failures<List<List<Answers>>>():
        final errorModel = ErrorHandler.formException(result.exception);
        emit(GetCachedFailuresState(errorModel: errorModel));
    }
  }
}
