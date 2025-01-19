import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quize_app/config/routes/page_route_name.dart';
import 'package:quize_app/core/extension/extension.dart';
import 'package:quize_app/src/presentation/result/view_model/result_cubit.dart';
import '../../../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/spaceing/spaceing.dart';
import '../../../../core/utils/widget/custom_button_widget.dart';
import '../../../domain/entities/check_question_entity.dart';
import '../view_model/exam_source_action.dart';
import '../view_model/exam_source_cubit.dart';

class ExamScoreContainer extends StatelessWidget {
  final CheckQuestionEntity checkQuestions;
  const ExamScoreContainer({super.key, required this.checkQuestions});
  @override
  Widget build(BuildContext context) {
    var examSourceViewModel = context.read<ExamSourceCubit>()
      ..doAction(FormatPercentageTargetAction(
          percentageWithSymbol: checkQuestions.total ?? "%"));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                context.localizations.yourScore,
                style: AppFonts.font18kBlack0Weight500FontInter,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircularPercentIndicator(
                radius: 70.00,
                animation: true,
                lineWidth: 7.0,
                percent: examSourceViewModel.roundedPercentage / 100,
                progressColor: AppColors.kBlue,
                backgroundColor: AppColors.kRed,
                center: Text(
                  examSourceViewModel.totalText,
                  style: AppFonts.font2kBlack0Weight500,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.localizations.correct,
                            style: AppFonts.font16kBlueWeight500FontInter,
                          ),
                          Text(
                            " ${checkQuestions.correct}",
                            style: AppFonts.font16kBlueWeight500FontInter,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.localizations.incorrect,
                              style: AppFonts.font16kRedWeight500FontInter),
                          Text("${checkQuestions.wrong}",
                              style: AppFonts.font16kRedWeight500FontInter),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        verticalSpace(
          50,
        ),
        CustomButtonWidget(
          onPressed: () {
            BlocProvider.of<ResultCubit>(context).selectedIndex =
                BlocProvider.of<ResultCubit>(context).questions.length - 1;
            Navigator.pushNamed(context, PageRouteName.resultAnswerScreen);
          },
          text: context.localizations.showResults,
          color: AppColors.kBlue,
          textColor: AppColors.kWhite,
        ),
        verticalSpace(
          25,
        ),
        CustomButtonWidget(
          onPressed: () =>
              examSourceViewModel.doAction(NavigateToStartAgainAnswerAction()),
          text: context.localizations.tryAgain,
          color: AppColors.kWhite,
          textColor: AppColors.kBlue,
        )
      ],
    );
  }
}
