import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:quize_app/core/caching/cache_keys.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/model/question/cache_model/question_cache_model.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/qestion_offline_data_source/question_offline_data_source.dart';
import 'package:quize_app/src/data/mappers/question_mapper.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';

@Injectable(as: QuestionOfflineDataSource)
class QuestionOfflineDataSourceImpl implements QuestionOfflineDataSource {
  final QuestionMapper questionMapper;
  var questionBox =
  Hive.box<List<QuestionCacheModel>>(CacheKeys.questionCachedKey);

  QuestionOfflineDataSourceImpl({required this.questionMapper});

  @override
  Future<void> cachedQuestion(
      {required List<QuestionEntity> questionEntity}) async {
    try {
      List<QuestionCacheModel> questions =
          questionMapper.toListQuestionCachedModel(questionEntity);
      await questionBox.add(questions);
    } catch (e) {
      throw Exception(  "Error caching exams: $e");
    }
  }

  @override
  Future<List<List<QuestionEntity>>> getCachedQuestion() async {
    try {
      List<List<QuestionCacheModel>>  questionCachedModel = questionBox.values.toList();
      return questionMapper.toListQuestionEntityCached(questionCachedModel);
    } catch (e) {
      print("e :$e");
      throw Exception("Error caching exams: $e");
    }
  }
}
