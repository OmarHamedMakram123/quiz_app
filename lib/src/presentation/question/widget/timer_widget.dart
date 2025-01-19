import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/routes/page_route_name.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/dialogs/loading_dialog.dart';
import '../../../../core/utils/dialogs/time_out_dialog.dart';
import '../../../data/model/request/check_answer_request.dart';
import '../view_model/questions_cubit.dart';
import '../view_model/timer/timer_cubit.dart';
import '../view_model/timer/timer_state.dart';

class TimerWidgetAction extends StatefulWidget {
  final int duration;
  const TimerWidgetAction({super.key, required this.duration});

  @override
  State<TimerWidgetAction> createState() => _TimerWidgetActionState();
}

class _TimerWidgetActionState extends State<TimerWidgetAction> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimerCubit>(context).initRemainingTimer(widget.duration);
    BlocProvider.of<TimerCubit>(context).startTime();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<TimerCubit>();
    return BlocListener<TimerCubit, TimerState>(
      listener: (context, state) {
        if (state is FinishTimerState) {
          TimeOutDialog.showTimeOutDialog(context: context,onPressedViewScore: ()=>_navigateToExamSourceScreen());
        }
      },
      child: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(right: 16.0.w),
            child: Text(
              viewModel.formattedTimer(),
              style: viewModel.isRemainingMoreThan15Minutes()
                  ? AppFonts.font20kGreen0Weight400FontInter
                  : AppFonts.font20kRed0Weight400FontInter,
            ),
          );
        },
      ),
    );
  }



  void _navigateToExamSourceScreen() {
    LoadingDialog.hide(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRouteName.examScoreScreen,
      (route) => false,
      arguments: CheckAnswerRequest(
          answers: BlocProvider.of<QuestionsCubit>(context).answerList,
          time: BlocProvider.of<TimerCubit>(context).remainingTime,
          subjectEntity: BlocProvider.of<QuestionsCubit>(context).questions[0].subjectEntity,
          examEntity: BlocProvider.of<QuestionsCubit>(context).examEntity
      ),

    );
  }
}