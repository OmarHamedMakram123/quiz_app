import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/data/model/request/check_answer_request.dart';
import 'package:quize_app/src/domain/entities/answer_entity.dart';
import 'package:quize_app/src/domain/entities/question_entity.dart';
import 'package:quize_app/src/domain/use_case/get_all_question_on_exam_by_id_use_case.dart';
import 'package:quize_app/src/presentation/question/view_model/questions_cubit.dart';

import 'question_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetAllQuestionOnExamByIdUseCase>()])
void main() {
  late GetAllQuestionOnExamByIdUseCase getAllQuestionOnExamByIdUseCase;
  late QuestionsCubit questionsCubit;
  setUp(
    () {
      getAllQuestionOnExamByIdUseCase = MockGetAllQuestionOnExamByIdUseCase();
      questionsCubit = QuestionsCubit(getAllQuestionOnExamByIdUseCase);
    },
  );
  group(
    "Test Question Cubit Method Do Action",
    () {
      blocTest<QuestionsCubit, QuestionsState>(
          "should return emit[GetAllQuestionLoadingState,GetAllQuestionSuccessState] when call doAction(GetAllQuestionOnExamByIdAction) is Successfully",
          build: () {
            var mockedResult = Success<List<QuestionEntity>>(date: []);
            provideDummy<Result<List<QuestionEntity>>>(mockedResult);
            when(getAllQuestionOnExamByIdUseCase.invoke(examId: "examId"))
                .thenAnswer(
              (realInvocation) async => mockedResult,
            );
            return questionsCubit;
          },
          act: (bloc) => questionsCubit.doAction(
                GetAllQuestionOnExamByIdAction(examId: "examId"),
              ),
          expect: () => <TypeMatcher<QuestionsState>>[
                isA<GetAllQuestionOnExamByIdLoadingState>(),
                isA<GetAllQuestionOnExamByIdSuccessState>()
              ]);
      blocTest<QuestionsCubit, QuestionsState>(
          "should return emit[GetAllQuestionLoadingState,GetAllQuestionOnExamByIdFailuresState] when call doAction(GetAllQuestionOnExamByIdAction) is failures",
          build: () {
            var mockedResult =
                Failures<List<QuestionEntity>>(exception: Exception());
            provideDummy<Result<List<QuestionEntity>>>(mockedResult);
            when(getAllQuestionOnExamByIdUseCase.invoke(examId: "examId"))
                .thenAnswer(
              (realInvocation) async => mockedResult,
            );
            return questionsCubit;
          },
          act: (bloc) => questionsCubit.doAction(
                GetAllQuestionOnExamByIdAction(examId: "examId"),
              ),
          expect: () => <TypeMatcher<QuestionsState>>[
                isA<GetAllQuestionOnExamByIdLoadingState>(),
                isA<GetAllQuestionOnExamByIdFailuresState>()
              ]);
        test(
        "should call _goNextButtonText and navigateToExamScreen when call doAction(_incrementCurrentQuestionIndex())  is  questionIndex == questions.length - 1 ",
        () {
          questionsCubit.questionIndex = 2;
          questionsCubit.questions = [
            QuestionEntity(),
            QuestionEntity(),
            QuestionEntity()
          ];
          var actual =
              questionsCubit.doAction(IncrementCurrentQuestionIndexAction());
          expect(questionsCubit.questionIndex, 2);
          expect(questionsCubit.textNextButton, "Finish");
          expect(questionsCubit.state, isA<NavigateToExamSourceScreenState>());
        },
      );

      blocTest<QuestionsCubit, QuestionsState>(
        "should add  currentIndexOptionsAnswer =newIndex  and call updateAnswerQuestion  and emit[ChangeSelectedOptionsAnswerState] when call doAction(ChangeSelectedOptionsAnswerAction)",
        build: () {
          return questionsCubit;
        },
        act: (bloc) {
          questionsCubit.questions = [
            QuestionEntity(questionId: '1', answer: []),
          ];
          questionsCubit
              .doAction(ChangeSelectedOptionsAnswerAction(newIndex: 1));
        },
        expect: () => <TypeMatcher<QuestionsState>>[
          isA<ChangeSelectedOptionsAnswerState>()
        ],
        verify: (bloc) {
          expect(questionsCubit.currentIndexOptionsAnswer, 1);
        },
      );

      blocTest<QuestionsCubit, QuestionsState>(
        "should add  ChangeCurrentQuestionIndexState and call getCurrentSelectedOptions  and emit[ChangeCurrentQuestionIndexState] when call doAction(_decrementCurrentQuestionIndex) is questionIndex > 0",
        build: () {
          return questionsCubit;
        },
        act: (bloc) {
          questionsCubit.questions = [
            QuestionEntity(
              questionId: '1',
              answer: [
                AnswerEntity(answer: "", key: ""),
              ],
            ),
            QuestionEntity(
              questionId: '2',
              answer: [
                AnswerEntity(answer: "", key: ""),
              ],
            ),
          ];
          questionsCubit.answer = [
            Answers(questionId: '1', correct: "o", currentIndexOptionSelection: -1),
            Answers(questionId: '2', correct: "o", currentIndexOptionSelection: -1),
          ];
          questionsCubit.questionIndex = 2;
          questionsCubit.doAction(DecrementCurrentQuestionIndexAction());
        },
        expect: () => <TypeMatcher<QuestionsState>>[
          isA<ChangeCurrentQuestionIndexState>()
        ],
        verify: (bloc) {
          expect(questionsCubit.questionIndex, 1);
        },
      );
  },

  );
}
