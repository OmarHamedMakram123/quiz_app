import '../../../../model/request/check_answer_request.dart';

abstract class AnswerOfflineDataSource {
  Future<void>cachedAnswer({required List<Answers> answers});
  Future<List<List<Answers>>>getCachedAnswer();
}