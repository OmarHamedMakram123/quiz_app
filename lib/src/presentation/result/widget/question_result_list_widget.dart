import 'package:flutter/material.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/presentation/result/widget/question_result_item_widget.dart';
import '../../../../core/utils/functions/spaceing/spaceing.dart';
import '../../../domain/entities/question_entity.dart';

class QuestionResultListWidget extends StatelessWidget {
  final List<QuestionEntity> questions;
  final List<Answers> answers;
  const QuestionResultListWidget({super.key, required this.questions, required this.answers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return QuestionResultItemWidget(
          question: questions[index],
          answer:  answers[index],

        );
      },
      separatorBuilder: (context, index) => verticalSpace(24),
    );
  }
}
