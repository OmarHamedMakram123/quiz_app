import '../../../../../domain/entities/question_entity.dart';

abstract class QuestionOfflineDataSource {
  Future<void> cachedQuestion({required List<QuestionEntity> questionEntity});
  Future<List<List<QuestionEntity>>>getCachedQuestion();
}