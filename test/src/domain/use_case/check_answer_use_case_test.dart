import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/domain/entities/check_question_entity.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/repositories/answer_repository.dart';
import 'package:quize_app/src/domain/use_case/check_answer_use_case.dart';
import 'package:test/test.dart';

import 'mocked/moked_repository.mocks.dart';

void main() {
  test('should return Success<CheckQuestionEntity> when call answerRepository.checkAnswerQuestion', () async{
    AnswerRepository answerRepository=MockAnswerRepository();
    CheckAnswerUseCase checkAnswerUseCase=CheckAnswerUseCase(answerRepository: answerRepository);
    CheckAnswerRequest checkAnswerRequest=CheckAnswerRequest(examEntity: ExamEntity());
    CheckQuestionEntity checkQuestionEntity=CheckQuestionEntity();
    var mockedResult=Success<CheckQuestionEntity>(date: checkQuestionEntity);
    provideDummy<Result<CheckQuestionEntity>>(mockedResult);
    when(answerRepository.checkAnswer(checkAnswerRequest: checkAnswerRequest)).thenAnswer((realInvocation)async => mockedResult,);
    var actual=  await checkAnswerUseCase.invoke(checkAnswerRequest: checkAnswerRequest);
    expect(actual, isA<Success<CheckQuestionEntity>>());
  }
  );
}