sealed class QuestionsAction {}
class GetAllQuestionsAction extends QuestionsAction{final String examId;GetAllQuestionsAction({required this.examId});}
class IncrementQuestionIndexAction extends QuestionsAction{}
class DecrementQuestionIndexAction extends QuestionsAction{}
class UpdateAnswerSelectedIndex extends QuestionsAction {
  final int newIndex;
  UpdateAnswerSelectedIndex({required this.newIndex});
}
class NavigateToExamSourceAction extends QuestionsAction{}
class NavigateToQuestionAction extends QuestionsAction{}
