import 'package:injectable/injectable.dart';
import 'package:quize_app/src/domain/repositories/question_repository.dart';

import '../../../core/api/common/api_result.dart';
import '../entities/question_entity.dart';

@injectable
class GetAllQuestionOnExamByIdUseCase{
  final QuestionRepository questionRepository;
  GetAllQuestionOnExamByIdUseCase({required this.questionRepository});

  Future<Result<List<QuestionEntity>>>invoke({required String examId}){
    return questionRepository.getAllQuestionOnExamById(examId: examId);
  }
}