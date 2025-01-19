import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_model.dart';
import '../../../domain/entities/exam_entity.dart';
import '../../../domain/use_case/get_exam_on_subject_use_case.dart';
import 'exam_action.dart';

part 'exam_state.dart';

@injectable
class ExamCubit extends Cubit<ExamState> {
  final GetExamOnSubjectUseCase _getAllExamOnSubjectUseCase;
  ExamCubit(this._getAllExamOnSubjectUseCase)
      : super(GetExamOnSubjectInitial());


  Future<void>doAction(ExamAction examAction)async{
    switch (examAction) {
      case GetAllExamOnSubjectByIdAction():return await    _getAllExamOnSubjectId(subjectId: examAction.subjectId);
    }
  }


  List<ExamEntity> exams=[];
  Future<void> _getAllExamOnSubjectId({required String subjectId}) async {
    emit(GetExamOnSubjectLoadingState());
    var result = await _getAllExamOnSubjectUseCase.invoke(subjectId: subjectId);
    switch (result) {
      case Success<List<ExamEntity>>():
        exams=result.date;
        emit(GetExamOnSubjectSuccessState(exams: result.date));
      case Failures<List<ExamEntity>>():
        emit(GetExamOnSubjectErrorState(
            errorModel: ErrorHandler.formException(result.exception)));
    }
  }
}
