import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:quize_app/core/caching/cache_keys.dart';
import 'package:quize_app/src/data/mappers/answer_mapper.dart';
import 'package:quize_app/src/data/mappers/question_mapper.dart';
import '../../../../model/request/check_answer_request.dart';
import '../model/answer_cache_model/answer_cache_model.dart';
import 'answer_offline_data_source.dart';

@Injectable(as: AnswerOfflineDataSource)
class AnswerOfflineDataSourceImpl implements AnswerOfflineDataSource {
  final AnswerMapper answerMapper;
  var checkAnswerBox =
      Hive.box<List<CheckAnswerCachedModel>>(CacheKeys.answerCachedKey);

  AnswerOfflineDataSourceImpl({required this.answerMapper});
  @override
  Future<void> cachedAnswer({required List<Answers> answers}) async {
    try {
      List<CheckAnswerCachedModel> checkAnswerCachedModels =
          answerMapper.toListCheckAnswerCachedModel(answers: answers);
      await checkAnswerBox.put(
          CacheKeys.answerCachedKey, checkAnswerCachedModels);
    } catch (e) {
      throw Exception("Error caching exams: $e");
    }
  }

  @override
  Future<List<List<Answers>>> getCachedAnswer() async {
    try {
      print("loading :");
      List<List<CheckAnswerCachedModel>> answerModels =
          checkAnswerBox.values.toList();
      answerMapper.toListCheckAnswerEntity(answerModel: answerModels);
      print("success :");
      return answerMapper.toListCheckAnswerEntity(answerModel: answerModels);
    } catch (e) {
      print("failure answers : $e");
      throw Exception("Error caching answerCached : $e");
    }
  }
}
