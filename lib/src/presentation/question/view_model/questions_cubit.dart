import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/error/error_handler.dart';
import 'package:quize_app/core/error/error_model.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';
import 'package:quize_app/src/presentation/question/view_model/questions_action.dart';
import '../../../domain/use_case/get_all_question_on_exam_by_id_use_case.dart';

part 'questions_state.dart';

@injectable
class QuestionsCubit extends Cubit<QuestionsState> {
  GetAllQuestionOnExamByIdUseCase getAllQuestionOnExamByIdUseCase;
  QuestionsCubit(this.getAllQuestionOnExamByIdUseCase)
      : super(QuestionsInitial());

  Future<void> doAction(QuestionsAction questionAction) async {
    switch (questionAction) {
      case GetAllQuestionsAction():
        return await _getAllQuestionsOnExamById(examId: questionAction.examId);
      case IncrementQuestionIndexAction():
        return _incrementQuestionIndex();
      case DecrementQuestionIndexAction():
        return _decrementQuestionIndex();
      case UpdateAnswerSelectedIndex():
        return _updateSelectedAnswerIndex(questionAction.newIndex);
      case NavigateToExamSourceAction():
        return _navigateToExamSourceScreen();
      case NavigateToQuestionAction():
        return _navigateToExamScreen();
    }
  }

  List<QuestionEntity> questions = [];
  int questionIndex = 0;
  ExamEntity examEntity = ExamEntity();
  List<Answers> answerList = [];
  String buttonText = "Next";

  /// Handle The  Answer
  void _initializeAnswerList() {
    if (questions.isNotEmpty) {
      for (int i = 0; i < questions.length; i++) {
        answerList.add(Answers(
            questionId: questions[i].questionId,
            correct: questions[i].correct,
            currentIndexOptionSelection: -1,
            answerKey: "correctAnswer"));
      }
    }
  }

  void _incrementQuestionIndex() {
    if (questionIndex == questions.length - 1) {
      _navigateToExamSourceScreen();
    }
    if (questionIndex < questions.length - 1) {
      questionIndex += 1;
      _textButton();
      emit(IncrementQuestionIndexState());
    }
  }

  void _decrementQuestionIndex() {
    if (questionIndex > 0) {
      questionIndex -= 1;
      _textButton();
      emit(DecrementQuestionIndexState());
    }
  }

  void _updateSelectedAnswerIndex(int newIndex) {
    Answers answer = answerList[questionIndex];
    answer.currentIndexOptionSelection = newIndex;
    answer.answerKey = questions[questionIndex].answer?[newIndex].key;
    emit(UpdateSelectedAnswerIndex());
  }

  void _textButton() {
    if (questionIndex < questions.length - 1) {
      buttonText = "Next";
    } else {
      buttonText = "Finish";
    }
  }

  /// Navigation Screen
  void _navigateToExamSourceScreen() {
    emit(NavigateToExamSourceScreenState());
  }

  void _navigateToExamScreen() {
    emit(NavigateToExamSourceScreenState());
  }

  int getCurrentIndexOptionSelection() =>
      answerList[questionIndex].currentIndexOptionSelection ?? -1;
  Future<void> _getAllQuestionsOnExamById({required String examId}) async {
    emit(GetAllQuestionLoadingState());
    var result = await getAllQuestionOnExamByIdUseCase.invoke(examId: examId);
    switch (result) {
      case Success<List<QuestionEntity>>():
        questions = result.date;
        _initializeAnswerList();
        emit(GetAllQuestionSuccessState());
      case Failures<List<QuestionEntity>>():
        emit(GetAllQuestionFailuresState(
            errorModel: ErrorHandler.formException(result.exception)));
    }
  }
}
