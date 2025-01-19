import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quize_app/core/caching/cache_keys.dart';
import 'package:quize_app/quize_app.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/model/answer_cache_model/answer_cache_model.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/model/exam_cache_model/exam_cached_model.dart';
import 'package:quize_app/src/data/data_source/offline_data_source/result_offline_data_source/model/question/cache_model/question_cache_model.dart';
import 'dependency_injection/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  // Bloc.observer = MyBlocObserver();

  await Hive.initFlutter();
  Hive.registerAdapter(ExamCachedModelAdapter());
  Hive.registerAdapter(QuestionCacheModelAdapter());
  Hive.registerAdapter(AnswerCachedModelAdapter());
  Hive.registerAdapter(CheckAnswerCachedModelAdapter());
  await Hive.openBox<ExamCachedModel>(CacheKeys.examCachedKey);
  await Hive.openBox<List<QuestionCacheModel>>(CacheKeys.questionCachedKey);
  await Hive.openBox<List<CheckAnswerCachedModel>>(CacheKeys.answerCachedKey);
  runApp(const OnlineExamApp());
}
