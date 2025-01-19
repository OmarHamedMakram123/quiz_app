import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/core/utils/functions/handle_widget_state/handle_widget_state.dart';
import 'package:quize_app/src/presentation/result/view_model/result_action.dart';
import 'package:quize_app/src/presentation/result/view_model/result_cubit.dart';
import '../../../../config/routes/page_route_name.dart';
import '../../../domain/entities/exam_entity.dart';
import '../../exam/widget/exam_card_item_widget.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  void initState() {
    BlocProvider.of<ResultCubit>(context).doAction(GetCachedExamAction());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text( "Result")),
      body: BlocBuilder<ResultCubit,ResultState>(builder:(context, state) {
        if(state is GetCachedExamsLoadingState){
          return HandleWidgetState.buildLoadingWidget(context);
        }else if(state is GetCachedFailuresState){
          return HandleWidgetState.buildErrorWidget(context: context, errorModel: state.errorModel);
        }else {

          return HandleWidgetState.buildCheckListEmptyWidget(
              list: BlocProvider.of<ResultCubit>(context).exams,
              widget: examBodyWidget());
        }
      },)
    );
  }
  
  
  Widget examBodyWidget(){
    return    Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: BlocProvider.of<ResultCubit>(context).exams.length,
        itemBuilder: (context, index) {
          return  InkWell(
            onTap: () {
              BlocProvider.of<ResultCubit>(context).selectedIndex=index;
              Navigator.pushNamed(context,PageRouteName.resultAnswerScreen,);
              },
            child: ExamCardItemWidget(
              examEntity:ExamEntity(
                title: BlocProvider.of<ResultCubit>(context).exams[index].title,
                duration:BlocProvider.of<ResultCubit>(context).exams[index].duration,
                numberOfQuestions: BlocProvider.of<ResultCubit>(context).exams[index].numberOfQuestions,
                createdAt: BlocProvider.of<ResultCubit>(context).exams[index].createdAt,
                id: BlocProvider.of<ResultCubit>(context).exams[index].id,
              ) ,
            ),
          );
        },
      ),
    );
  }
}
