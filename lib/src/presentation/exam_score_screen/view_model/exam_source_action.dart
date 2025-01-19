import '../../../data/model/request/check_answer_request.dart';

sealed class ExamSourceAction {}

class CheckAnswerQuestionButtonAction extends ExamSourceAction{
 final CheckAnswerRequest checkAnswerRequest;
  CheckAnswerQuestionButtonAction({required this.checkAnswerRequest});
}
class NavigateToExamScreenAction extends ExamSourceAction{}

class NavigateToStartAgainAnswerAction extends ExamSourceAction {}

class FormatPercentageTargetAction extends ExamSourceAction{
final String percentageWithSymbol;
  FormatPercentageTargetAction({required this.percentageWithSymbol});
}


