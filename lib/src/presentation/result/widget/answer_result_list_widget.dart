import 'package:flutter/material.dart';
import '../../../../core/utils/functions/spaceing/spaceing.dart';
import '../../../data/model/request/check_answer_request.dart';
import '../../../domain/entities/answer_entity.dart';
import 'answer_result_list_item_widget.dart';

class AnswerResultListWidget extends StatefulWidget {
  final List<AnswerEntity> answers;
  final Answers answersCached;
  const AnswerResultListWidget(
      {super.key, required this.answers, required this.answersCached});

  @override
  State<AnswerResultListWidget> createState() => _AnswerResultListWidgetState();
}

class _AnswerResultListWidgetState extends State<AnswerResultListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.answers.length,
      itemBuilder: (context, index) {
        return AnswerResultItemWidget(
          borderColor: getColor(index),
          radioColor: getRadioColor(index),
          isCheckRadioColor: getCheckRadioColor(index),
          answerEntity: widget.answers[index],
        );
      },
      separatorBuilder: (context, index) => verticalSpace(10),
    );
  }



  Color? getColor(int index) {
    if (widget.answersCached.correct == widget.answers[index].key) {
      return Color(0xFFCAF9CC);
    } else if (widget.answersCached.currentIndexOptionSelection != -1 &&
        widget.answers[widget.answersCached.currentIndexOptionSelection ?? 0]
                .key ==
            widget.answers[index].key) {
      return Color(0xFFF8D2D2);
    }
    return null;
  }

  Color? getRadioColor(int index) {
    if (widget.answersCached.correct == widget.answers[index].key) {
      return const Color(0xFF11CE19);
    } else if (widget.answersCached.currentIndexOptionSelection != -1 &&
        widget.answers[widget.answersCached.currentIndexOptionSelection ?? 0]
                .key ==
            widget.answers[index].key) {
      return const Color(0xFFCC1010);
    } else {
      return const Color(0xFF02369C);
    }
  }

  bool getCheckRadioColor(int index) {
    if (widget.answersCached.correct == widget.answers[index].key) {
      return false;
    } else if (widget.answersCached.currentIndexOptionSelection != -1 &&
        widget.answers[widget.answersCached.currentIndexOptionSelection ?? 0]
                .key ==
            widget.answers[index].key) {
      return true;
    } else {
      return false;
    }
  }
}
