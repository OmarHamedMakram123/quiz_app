import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/src/presentation/result/view_model/result_action.dart';
import 'package:quize_app/src/presentation/result/view_model/result_cubit.dart';
import 'package:quize_app/src/presentation/result/widget/question_result_list_widget.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/functions/handle_widget_state/handle_widget_state.dart';

class ResultAnswerQuestionView extends StatefulWidget {
  const ResultAnswerQuestionView({super.key});

  @override
  State<ResultAnswerQuestionView> createState() => _ResultAnswerQuestionViewState();
}

class _ResultAnswerQuestionViewState extends State<ResultAnswerQuestionView> {

  @override
  Widget build(BuildContext context) {
    var resultCubit = context.read<ResultCubit>()
      ..doAction(GetCachedQuestionAction())
      ..doAction(GetCachedAnswerAction());
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        appBar: AppBar(
          title: const Text("Answers"),
        ),
        body: BlocBuilder<ResultCubit, ResultState>(
            builder: (context, state) =>
                _handleBlocBuilderResultCubit(context, state)));
  }

  Widget _handleBlocBuilderResultCubit(
      BuildContext context, ResultState state) {
    var resultCubit = BlocProvider.of<ResultCubit>(context);
    if (state is GetCachedQuestionLoadingState ||
        state is GetCachedAnswerLoadingState) {
      return HandleWidgetState.buildLoadingWidget(context);
    } else if (state is GetCachedQuestionFailuresState) {
      return HandleWidgetState.buildErrorWidget(
          context: context, errorModel: state.errorModel, onPressed: () {});
    } else if (state is GetCachedAnswerFailuresState) {
      return HandleWidgetState.buildErrorWidget(
          context: context, errorModel: state.errorModel, onPressed: () {});
    } else {
      if(resultCubit.questions.isEmpty){
        return SizedBox.shrink();
      }
      return HandleWidgetState.buildCheckListEmptyWidget(
          list: resultCubit.questions,
          widget: QuestionResultListWidget(
            questions: resultCubit.questions[resultCubit.selectedIndex],
            answers: resultCubit.answers[resultCubit.selectedIndex],
          ));
    }
  }
}
