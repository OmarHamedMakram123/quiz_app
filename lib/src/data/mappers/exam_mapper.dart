import 'package:injectable/injectable.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/model/exam_cache_model/exam_cached_model.dart';

import '../../domain/entities/exam_entity.dart';
import '../model/response/exam_response_model/exam_response_model.dart';

abstract class ExamMapper{
  List<ExamEntity>toExamEntity(ExamResponseModel examResponseModel);
  ExamCachedModel toExamCachedModel({required ExamEntity examEntity});
  List<ExamEntity> toExamEntityCached({required List<ExamCachedModel> examsCached});
}


@Injectable(as: ExamMapper)
class ExamMapperImpl implements ExamMapper{
  @override
  List<ExamEntity>toExamEntity(ExamResponseModel examResponseModel) {
    if(examResponseModel.exams ==null )return [];
   List<ExamEntity>exams= examResponseModel.exams!.map((e) => _toExamEntity(e),).toList();
   return exams;
  }
  ExamEntity _toExamEntity(Exams exams){
    return ExamEntity(
      id: exams.Id,
      numberOfQuestions: exams.numberOfQuestions,
      duration: exams.duration,
      title: exams.title,
      createdAt: exams.createdAt
    );
  }


  @override
  ExamCachedModel toExamCachedModel({required ExamEntity examEntity}){
    return ExamCachedModel(
      title: examEntity.title,
      numberOfQuestions: examEntity.numberOfQuestions,
      duration: examEntity.duration,
      id: examEntity.id,
      createdAt: examEntity.createdAt
    );
  }





  @override
  List<ExamEntity> toExamEntityCached({required List<ExamCachedModel> examsCached}){
    if(examsCached.isEmpty)return [];
    List<ExamEntity>exams=
    examsCached.map((examCachedModel) =>_toExamCachedEntity(examCachedModel) ,).toList();
    return exams;
  }


  ExamEntity _toExamCachedEntity(ExamCachedModel examCachedModel){
    return ExamEntity(
      id: examCachedModel.id,
      createdAt: examCachedModel.createdAt,
      duration: examCachedModel.duration,
      numberOfQuestions: examCachedModel.numberOfQuestions,
      title: examCachedModel.title
    );
  }

}