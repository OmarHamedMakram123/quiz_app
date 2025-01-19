import 'package:flutter/material.dart';
import '../../../../config/routes/page_route_name.dart';
import '../../../domain/entities/exam_entity.dart';
import 'exam_card_item_widget.dart';

class ExamCardListWidget extends StatelessWidget {
  final List<ExamEntity> exams;
  const ExamCardListWidget({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => InkWell(
          onTap: () async {
            Navigator.pushNamed(
                // ignore: use_build_context_synchronously
                context,
                PageRouteName.startExamScreen,
                arguments: exams[index]);
          },
          child: ExamCardItemWidget(examEntity: exams[index])),
      itemCount: exams.length,
    );
  }
}
