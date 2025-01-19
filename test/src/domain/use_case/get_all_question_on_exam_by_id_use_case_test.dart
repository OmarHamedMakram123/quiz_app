import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';
import 'package:quize_app/src/domain/repositories/question_repository.dart';
import 'package:quize_app/src/domain/use_case/get_all_question_on_exam_by_id_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocked/moked_repository.mocks.dart';

void main() {
  test('should return ApiResult<List<QuestionEntity> when call questionRepository.getAllQuestionOnSubjectById', () async{
    QuestionRepository questionRepository=MockQuestionRepository();
    GetAllQuestionOnExamByIdUseCase getAllQuestionOnExamByIdUseCase=GetAllQuestionOnExamByIdUseCase(questionRepository: questionRepository);
    var mockedResult=Success<List<QuestionEntity>>(date: []);
    provideDummy<Result<List<QuestionEntity>>>(mockedResult);
    when(questionRepository.getAllQuestionOnExamById(examId: "")).thenAnswer((realInvocation) async => mockedResult,);
    var actual=await getAllQuestionOnExamByIdUseCase.invoke(examId: "");
    expect(actual, isA<Success<List<QuestionEntity>>>());
  });
}