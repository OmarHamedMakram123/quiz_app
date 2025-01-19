import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/caching/cache_keys.dart';
import '../../../../../domain/entities/exam_entity.dart';
import '../../../../mappers/exam_mapper.dart';
import '../model/exam_cache_model/exam_cached_model.dart';
import 'exam_offline_data_source.dart';

@Injectable(as: ExamOfflineDataSource)
class ExamOfflineDataSourceImpl implements ExamOfflineDataSource {
  final ExamMapper examMapper;
  ExamOfflineDataSourceImpl({required this.examMapper});

  var examBox = Hive.box<ExamCachedModel>(CacheKeys.examCachedKey);
  @override
  Future<void> cachedExam({required ExamEntity examEntity}) {
    try {
      ExamCachedModel examCachedModel = examMapper.toExamCachedModel(examEntity: examEntity);
      return examBox.add(examCachedModel);
    } catch (e) {
      throw Exception("Error caching exams: $e");
    }
  }

  @override
  Future<List<ExamEntity>> getCachedExam() async {
    try {
      List<ExamCachedModel> examCachedModel = examBox.values.toList();
      return examMapper.toExamEntityCached(examsCached: examCachedModel);
    } catch (e) {
      throw Exception("Error caching exams: $e");
    }
  }
}
