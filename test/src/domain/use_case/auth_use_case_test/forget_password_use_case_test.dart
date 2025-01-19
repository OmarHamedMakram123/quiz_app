import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/data/model/request/forget_password_request.dart';
import 'package:quize_app/src/domain/entities/success_auth_entity.dart';
import 'package:quize_app/src/domain/repositories/auth_repository.dart';
import 'package:quize_app/src/domain/use_case/auth_use_case/forget_password_use_case.dart';
import 'package:test/test.dart';

import '../mocked/moked_repository.mocks.dart';

void main() {
  test('should return success<SuccessAuthEntity> when  call authRepository.forgetPassword', ()async {
    ForgetPasswordRequest forgetPasswordRequest=ForgetPasswordRequest(email: "email");
    SuccessAuthEntity successAuthEntity=SuccessAuthEntity();
    AuthRepository authRepository=MockAuthRepository();
    ForgetPasswordUseCase forgetPasswordUseCase=ForgetPasswordUseCase(authRepository: authRepository);
    var mockedResult=Success<SuccessAuthEntity>(date: successAuthEntity);
    provideDummy<Result<SuccessAuthEntity>>(mockedResult);
    when(authRepository.forgetPassword(forgetPasswordRequest: forgetPasswordRequest)).thenAnswer((realInvocation) async=> mockedResult,);
    var actual=await forgetPasswordUseCase.invoke(forgetPasswordRequest: forgetPasswordRequest);
    expect(actual, mockedResult);
  });
}