import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/config/routes/page_route_name.dart';
import 'package:quize_app/core/extension/extension.dart';
import 'package:quize_app/core/utils/functions/handle_widget_state/handle_widget_state.dart';
import 'package:quize_app/dependency_injection/di.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/presentation/question/view_model/questions_action.dart';
import 'package:quize_app/src/presentation/question/view_model/timer/timer_cubit.dart';
import 'package:quize_app/src/presentation/question/widget/timer_widget.dart';
import 'package:quize_app/src/presentation/result/view_model/result_cubit.dart';
import '../../result/view_model/result_action.dart';
import '../view_model/questions_cubit.dart';
import '../widget/question_body_widget.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  var questionViewModel = getIt.get<QuestionsCubit>();
  @override
  Widget build(BuildContext context) {
    questionViewModel.examEntity =
        ModalRoute.of(context)!.settings.arguments as ExamEntity;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => questionViewModel
              ..doAction(GetAllQuestionsAction(
                  examId: questionViewModel.examEntity.id ?? ""))),
        BlocProvider(
          create: (context) => getIt.get<TimerCubit>(),
        )
      ],
      child: BlocConsumer<QuestionsCubit, QuestionsState>(
          listener: (context, state) => _handleBlocListenerState(state),
          builder: (context, state) => _handleBlocBuilderWidget(state)),
    );
  }

  Widget _handleBlocBuilderWidget(QuestionsState state) {
    if (state is GetAllQuestionLoadingState) {
      return Scaffold(body: HandleWidgetState.buildLoadingWidget(context));
    } else if (state is GetAllQuestionFailuresState) {
      return Scaffold(
          body: HandleWidgetState.buildErrorWidget(
              context: context, errorModel: state.errorModel));
    } else {
      return Scaffold(
        appBar: buildAppBar(questionViewModel.examEntity),
        body: HandleWidgetState.buildCheckListEmptyWidget(
            list: questionViewModel.questions, widget: QuestionBodyWidget()),
      );
    }
  }

  void _handleBlocListenerState(QuestionsState state) async {
    if (state is NavigateToExamSourceScreenState) {
      BlocProvider.of<ResultCubit>(context).doAction(
          CachedListAnswerAction(answers: questionViewModel.answerList));
      _navigateToExamSourceScreen();
    } else if (state is GetAllQuestionSuccessState) {
      _cachedQuestionDataAndAnswerData();
    }
  }

  void _cachedQuestionDataAndAnswerData(){
    BlocProvider.of<ResultCubit>(context).doAction(
        CachedListExamAction(examsEntity: questionViewModel.examEntity));
    BlocProvider.of<ResultCubit>(context).doAction(
        CachedListQuestionAction(questions: questionViewModel.questions));

  }

  void _navigateToExamSourceScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, PageRouteName.examScoreScreen, (route) => false,
        arguments: CheckAnswerRequest(
            answers: questionViewModel.answerList,
            time: 10,
            subjectEntity: questionViewModel.questions[0].subjectEntity,
            examEntity: questionViewModel.examEntity));
  }


  AppBar buildAppBar(ExamEntity examEntity) {
    return AppBar(
      title: Text(examEntity.title ?? "${context.localizations.exam} "),
      actions: [
        TimerWidgetAction(duration: examEntity.duration?.toInt() ?? 25),
      ],
    );
  }
}
