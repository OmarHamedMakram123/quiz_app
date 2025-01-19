import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quize_app/core/extension/extension.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/spaceing/spaceing.dart';
import '../../../domain/entities/exam_entity.dart';

class ExamCardItemWidget extends StatelessWidget {
  final ExamEntity examEntity;
  const ExamCardItemWidget({super.key, required this.examEntity});

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 11 ,
        color: AppColors.kWhite,
        child: Container(
          height:103.h ,
          width: 343.w,
          margin: EdgeInsets.only(top: 24.h,right: 24.w,left: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Image.asset(
                 AppImages.exams,
                 height: 71.h,
                 width: 60.w,
                 fit: BoxFit.fill,
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(examEntity.title ?? " ${context.localizations.highLevel}",style: AppFonts.font16BlackWeight500FontInter,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 4.h,),
                    Text("${examEntity.numberOfQuestions} ${context.localizations.questions}",style: AppFonts.font13GrayWeight400FontInter,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 16.h,),
                    Text("Form ${examEntity.createdAt}. ",style: AppFonts.font13BlackWeight500FontInter,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
              horizontalSpace(5),
              SizedBox(
                width: 69.w,
                height: 16.h,
                child: Text("${examEntity.duration}${context.localizations.minutes}",style: AppFonts.font13BlueWeight400FontInter,maxLines: 1,overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        )
    );
  }
}
