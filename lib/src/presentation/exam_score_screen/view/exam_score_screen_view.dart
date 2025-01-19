import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/core/extension/extension.dart';
import '../../../../config/routes/page_route_name.dart';
import '../../../../core/utils/functions/handle_widget_state/handle_widget_state.dart';
import '../../../../dependency_injection/di.dart';
import '../../../data/model/request/check_answer_request.dart';
import '../../../domain/entities/check_question_entity.dart';
import '../../../domain/entities/exam_entity.dart';
import '../view_model/exam_source_action.dart';
import '../view_model/exam_source_cubit.dart';
import '../widget/exam_score_container.dart';

class ExamScoreScreenView extends StatefulWidget {
  const ExamScoreScreenView({super.key});

  @override
  State<ExamScoreScreenView> createState() => _ExamScoreScreenViewState();
}

class _ExamScoreScreenViewState extends State<ExamScoreScreenView> {
  var examSourceViewModel = getIt.get<ExamSourceCubit>();

  @override
  Widget build(BuildContext context) {
    examSourceViewModel. changeAnswerRequest =
        ModalRoute.of(context)!.settings.arguments as CheckAnswerRequest;
    return BlocProvider(
        create: (context) => examSourceViewModel..doAction(CheckAnswerQuestionButtonAction(checkAnswerRequest: examSourceViewModel.changeAnswerRequest)),
        child: Scaffold(
          appBar: AppBar(
            title:  Text(                             context.localizations.examSource,),
            leading: IconButton(
              onPressed: () => examSourceViewModel.doAction(NavigateToExamScreenAction()),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: BlocListener<ExamSourceCubit, ExamSourceState>(
            listener: (context, state) => _handleBlocListenerAnswerCubit(state,examSourceViewModel.changeAnswerRequest.examEntity),
            child: BlocBuilder<ExamSourceCubit, ExamSourceState>(
                builder: (context, state) =>
                    _handleBlocBuilderAnswerCubit(state)),
          ),
        ));
  }




  Widget _handleBlocBuilderAnswerCubit(ExamSourceState examSourceState) {
    if (examSourceState is CheckAnswerQuestionLoadingState) {
      return HandleWidgetState.buildLoadingWidget(context);
    } else if (examSourceState is CheckAnswerQuestionFailuresState) {
      return HandleWidgetState.buildErrorWidget(
          context: context, errorModel: examSourceState.errorModel);
    } else {
      final checkAnswerEntity = examSourceViewModel.checkQuestionEntity;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExamScoreContainer(
          checkQuestions: CheckQuestionEntity(
              correct: checkAnswerEntity.correct,
              message: checkAnswerEntity.message,
              total: checkAnswerEntity.total,
              wrong: checkAnswerEntity.wrong),
        ),
      );
    }
  }
  void _handleBlocListenerAnswerCubit(ExamSourceState examSourceState,ExamEntity examEntity) {
    if (examSourceState is NavigateToExamScreenState) {
      _goNextExamScreen(examEntity:examEntity);
    }else if (examSourceState is NavigateToStartAgainAnswerState){
      _goNextStartAgainQuestion(examEntity: examEntity);
    }
  }
  void _goNextExamScreen({required ExamEntity examEntity}) {
    Navigator.pushNamedAndRemoveUntil(
        context,
        PageRouteName.exam,
            (route) => false,
        arguments:  examSourceViewModel. changeAnswerRequest.subjectEntity
    );
  }
  void _goNextStartAgainQuestion({required ExamEntity examEntity}) {
    Navigator.pushNamedAndRemoveUntil(
        context,
        PageRouteName.questionsScreen,
            (route) => false,
        arguments:  examSourceViewModel. changeAnswerRequest.examEntity
    );
  }
}
