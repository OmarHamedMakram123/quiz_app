import '../../../../../domain/entities/exam_entity.dart';

abstract class ExamOfflineDataSource {
  Future<List<ExamEntity>> getCachedExam();
  Future<void> cachedExam({required ExamEntity examEntity});
}

