import 'package:hive/hive.dart';
part 'answer_cache_model.g.dart';
@HiveType(typeId: 4)
class CheckAnswerCachedModel {
  CheckAnswerCachedModel({
    this.questionId,
    this.correct,
    this.currentIndexOptionSelection,
   required this.answerKey
  });

  @HiveField(1)
  String? questionId;
  @HiveField(2)
  String? correct;
  @HiveField(3)
  int ? currentIndexOptionSelection;
  @HiveField(4)
  String  answerKey;

}