import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/domain/entities/exam_entity.dart';
import 'package:quize_app/src/domain/repositories/exam_repository.dart';
import 'package:quize_app/src/domain/use_case/get_exam_on_subject_use_case.dart';

import 'mocked/moked_repository.mocks.dart';

void main() {
  test('should return Success<List<ExamEntity>>when call examRepository.getExamOnSubjectById is success', () async{
   ExamRepository examRepository=MockExamRepository();
   GetExamOnSubjectUseCase getExamOnSubjectUseCase=GetExamOnSubjectUseCase(examRepository: examRepository);
   var mockedResult=Success<List<ExamEntity>>(date: []);
   provideDummy<Result<List<ExamEntity>>>(mockedResult);
   String subjectId ="";
   when(examRepository.getExamOnSubject(subjectId: subjectId)).thenAnswer((realInvocation)async =>mockedResult ,);
   var actual=await getExamOnSubjectUseCase.invoke(subjectId: subjectId);
   expect(actual, isA<Success<List<ExamEntity>>>());
  });
}