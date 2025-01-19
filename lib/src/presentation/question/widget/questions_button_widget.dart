import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quize_app/src/presentation/question/view_model/questions_action.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/spaceing/spaceing.dart';
import '../view_model/questions_cubit.dart';

class QuestionsButtonWidget extends StatefulWidget {
  const QuestionsButtonWidget({super.key});

  @override
  State<QuestionsButtonWidget> createState() => _QuestionsButtonWidgetState();
}

class _QuestionsButtonWidgetState extends State<QuestionsButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var questionViewModel=context.read<QuestionsCubit>();
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        return Row(
          children: [
            buildButton("Back", AppColors.kWhite, AppColors.kBlue50, () =>questionViewModel.doAction(DecrementQuestionIndexAction()),),
            horizontalSpace(16),
            buildButton(questionViewModel.buttonText, AppColors.kBlue, AppColors.kWhite, () =>questionViewModel.doAction(IncrementQuestionIndexAction())
            )

          ],
        );
      },
    );
  }

  Widget buildButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return Expanded(
      child: SizedBox(
        height: 48.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: ContinuousRectangleBorder(
              side: const BorderSide(color: AppColors.kBlue50),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          onPressed: onPressed,
          child: Text(text,
              style: AppFonts.font16kBlueWeight500FontInter
                  .copyWith(color: textColor)),
        ),
      ),
    );
  }
}
