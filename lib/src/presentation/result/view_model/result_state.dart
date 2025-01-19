part of 'result_cubit.dart';

sealed class ResultState {}

final class ResultInitial extends ResultState {}

class GetCachedExamsLoadingState extends ResultState {}

class GetCachedSuccessState extends ResultState {}

class GetCachedFailuresState extends ResultState {
  final ErrorModel errorModel;
  GetCachedFailuresState({required this.errorModel});
}

class CachedExamLoadingState extends ResultState {}

class CachedExamSuccessState extends ResultState {}

class CachedExamFailuresState extends ResultState {
  final ErrorModel errorModel;
  CachedExamFailuresState({required this.errorModel});
}

class GetCachedQuestionLoadingState extends ResultState {}

class GetCachedQuestionSuccessState extends ResultState {}

class GetCachedQuestionFailuresState extends ResultState {
  final ErrorModel errorModel;
  GetCachedQuestionFailuresState({required this.errorModel});
}

class CachedQuestionLoadingState extends ResultState {}

class CachedQuestionSuccessState extends ResultState {}

class CachedQuestionFailuresState extends ResultState {
  final ErrorModel errorModel;
  CachedQuestionFailuresState({required this.errorModel});
}

class GetCachedAnswerLoadingState extends ResultState {}

class GetCachedAnswerSuccessState extends ResultState {}

class GetCachedAnswerFailuresState extends ResultState {
  final ErrorModel errorModel;
  GetCachedAnswerFailuresState({required this.errorModel});
}

class CachedAnswerLoadingState extends ResultState {}

class CachedAnswerSuccessState extends ResultState {}

class CachedAnswerFailuresState extends ResultState {
  final ErrorModel errorModel;
  CachedAnswerFailuresState({required this.errorModel});
}
