import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/data/model/request/reset_password_request.dart';
import 'package:quize_app/src/domain/entities/success_auth_entity.dart';
import 'package:quize_app/src/domain/repositories/auth_repository.dart';
import 'package:quize_app/src/domain/use_case/auth_use_case/reset_password_use_case.dart';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

import '../mocked/moked_repository.mocks.dart';

void main() {

  test('should return success<SuccessAuthEntity> when  call authRepository.resetPassword', ()async {
    ResetPasswordRequest resetPasswordRequest=ResetPasswordRequest(email: "email",newPassword: "");
    SuccessAuthEntity successAuthEntity=SuccessAuthEntity();
    AuthRepository authRepository=MockAuthRepository();
    ResetPasswordUseCase  resetPasswordUseCase=ResetPasswordUseCase(authRepository: authRepository);
    var mockedResult=Success<SuccessAuthEntity>(date: successAuthEntity);
    provideDummy<Result<SuccessAuthEntity>>(mockedResult);
    when(authRepository.resetPassword(resetPasswordRequest: resetPasswordRequest)).thenAnswer((realInvocation) async=> mockedResult,);
    var actual=await resetPasswordUseCase.invoke(resetPasswordRequest: resetPasswordRequest);
    expect(actual, mockedResult);
  });
}