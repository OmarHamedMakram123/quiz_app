import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/model/exam_cache_model/exam_cached_model.dart';
import 'package:quize_app/src/data/mappers/exam_mapper.dart';
import 'package:quize_app/src/data/model/response/exam_response_model/exam_response_model.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

void main() {
  ExamMapperImpl examMapperImpl=ExamMapperImpl();
  test('should return empty list examEntity when call examMapper.toListExamEntity', () {
    ExamResponseModel examResponseModel=ExamResponseModel(exams: []);
    List<ExamEntity>exams=[];
     var actual=examMapperImpl.toExamEntity(examResponseModel);
    expect(actual, exams);
  });

  test('should return listExamEntity when call examMapper.toListExamEntity', () {
    ExamResponseModel examResponseModel=ExamResponseModel(exams: [Exams(title: "omar",)]);
    var actual=examMapperImpl.toExamEntity(examResponseModel);
    expect(actual[0].title, "omar" );
  });


  test('should return  examCachedModel when call examMapper.toExamCachedModel', () {
    ExamEntity examEntity=ExamEntity(id: "omar");
    var actual=examMapperImpl.toExamCachedModel(examEntity: examEntity);
    expect(actual.id, "omar");
  });



  test('should return empty list examEntity when call examMapper.toExamEntityCached', () {
    ExamCachedModel examResponseModel=ExamCachedModel();
    List<ExamCachedModel>examsCached=[];
    var actual=examMapperImpl.toExamEntityCached(examsCached: examsCached);
    expect(actual, examsCached);
  });

  test('should return listExamEntity when call examMapper.toExamEntityCached', () {
    ExamCachedModel examResponseModel=ExamCachedModel();
    List<ExamCachedModel>examsCached=[
      ExamCachedModel(title: "omar")
    ];
    var actual=examMapperImpl.toExamEntityCached(examsCached:examsCached );
    expect(actual[0].title, "omar" );
  });


}