part of 'questions_cubit.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}
class GetAllQuestionLoadingState extends QuestionsState{}
class GetAllQuestionSuccessState extends QuestionsState{}
class GetAllQuestionFailuresState extends QuestionsState{
  final ErrorModel errorModel;
   GetAllQuestionFailuresState({required this.errorModel});
}
class IncrementQuestionIndexState extends QuestionsState{}
class DecrementQuestionIndexState extends QuestionsState{}
class UpdateSelectedAnswerIndex extends QuestionsState {}
class NavigateToExamSourceScreenState extends QuestionsState{}
class NavigateToExamScreenState extends QuestionsState{}
