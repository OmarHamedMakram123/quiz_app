import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_model.dart';
import '../../../data/model/request/check_answer_request.dart';
import '../../../domain/entities/check_question_entity.dart';
import '../../../domain/use_case/check_answer_use_case.dart';
import 'exam_source_action.dart';

part 'exam_source_state.dart';

@injectable
class ExamSourceCubit extends Cubit<ExamSourceState> {
  final CheckAnswerUseCase checkAnswerUseCase;
  ExamSourceCubit(this.checkAnswerUseCase) : super(ExamSourceInitial());

  Future<void> doAction(ExamSourceAction examSourceAction)async{
       switch (examSourceAction) {
         case CheckAnswerQuestionButtonAction():
           return await _checkAnswerQuestion(changeAnswerRequest: examSourceAction.checkAnswerRequest);
         case NavigateToExamScreenAction():
         return _navigateToExamScreen();
         case FormatPercentageTargetAction():
           return _formatPercentage(examSourceAction.percentageWithSymbol);
         case NavigateToStartAgainAnswerAction():
         return _navigateToStartAgainScreen();
       }
     }


  CheckAnswerRequest changeAnswerRequest=   CheckAnswerRequest(
    examEntity: ExamEntity()
  );
  CheckQuestionEntity checkQuestionEntity=CheckQuestionEntity();
   Future<void> _checkAnswerQuestion({required CheckAnswerRequest changeAnswerRequest})async{
       emit(CheckAnswerQuestionLoadingState());
    var result= await checkAnswerUseCase.invoke(checkAnswerRequest: changeAnswerRequest);
   switch (result) {
     case Success<CheckQuestionEntity>():
       checkQuestionEntity=result.date;
       emit(CheckAnswerQuestionSuccessState());
     case Failures<CheckQuestionEntity>():
       final errorModel=ErrorHandler.formException(result.exception);
       emit(CheckAnswerQuestionFailuresState(errorModel: errorModel));
   }
  }

  void _navigateToExamScreen(){
     emit(NavigateToExamScreenState());
  }
  void _navigateToStartAgainScreen(){
    emit(NavigateToStartAgainAnswerState());
  }


  int roundedPercentage =0;
   String totalText= "0";
  void _formatPercentage(String percentageWithSymbol) {
    String cleanedPercentage = percentageWithSymbol.replaceAll("%", "");
    roundedPercentage = double.parse(cleanedPercentage).toInt();
    totalText= "$roundedPercentage%";
  }
}
