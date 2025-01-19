import 'package:mockito/annotations.dart';
import 'package:quize_app/src/domain/repositories/answer_repository.dart';
import 'package:quize_app/src/domain/repositories/auth_repository.dart';
import 'package:quize_app/src/domain/repositories/exam_repository.dart';
import 'package:quize_app/src/domain/repositories/question_repository.dart';
import 'package:quize_app/src/domain/repositories/subject_repository.dart';

@GenerateMocks(
    [AuthRepository,
      SubjectRepository,
      ExamRepository,
      AnswerRepository,
      QuestionRepository
    ])
void main(){}