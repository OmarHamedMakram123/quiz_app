import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/config/routes/page_route_name.dart';

import '../../../../core/utils/functions/handle_widget_state/handle_widget_state.dart';
import '../../../../dependency_injection/di.dart';
import '../../../domain/entities/subject_entity.dart';
import '../view_model/exam_action.dart';
import '../view_model/exam_cubit.dart';
import '../widget/exam_card_list_widget.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  var examViewModel = getIt.get<ExamCubit>();

  @override
  Widget build(BuildContext context) {
    SubjectEntity args =
        ModalRoute.of(context)!.settings.arguments as SubjectEntity;
    return BlocProvider(
      create: (context) => examViewModel
        ..doAction(GetAllExamOnSubjectByIdAction(
            subjectId: args.id ?? "670038f7728c92b7fdf43501")),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _navigateToBaseScreen(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(args.name ?? "Language"),
        ),
        body: BlocBuilder<ExamCubit, ExamState>(
          builder: (context, state) {
            if (state is GetExamOnSubjectLoadingState) {
              return HandleWidgetState.buildLoadingWidget(context);
            } else if (state is GetExamOnSubjectErrorState) {
              return HandleWidgetState.buildErrorWidget(
                  context: context, errorModel: state.errorModel);
            } else {
              return HandleWidgetState.buildCheckListEmptyWidget(
                  list: examViewModel.exams,
                  widget: ExamCardListWidget(
                    exams: examViewModel.exams,
                  ));
            }
          },
        ),
      ),
    );
  }

  void _navigateToBaseScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRouteName.baseScreen,
      (route) => false,
    );
  }
}
