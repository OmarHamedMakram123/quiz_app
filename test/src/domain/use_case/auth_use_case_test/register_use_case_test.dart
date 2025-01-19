import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/data/model/request/register_request.dart';
import 'package:quize_app/src/domain/entities/app_user_entity.dart';
import 'package:quize_app/src/domain/repositories/auth_repository.dart';
import 'package:quize_app/src/domain/use_case/auth_use_case/register_use_case.dart';

import '../mocked/moked_repository.mocks.dart';

void main() {
  test(
      'should return Success<AppUserEntity when call RegisterUserCase.invoke is Success>',
      () async {
    RegisterRequest registerRequest = RegisterRequest(
        username: "username",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        password: "password",
        rePassword: "rePassword",
        phone: "phone");
    AuthRepository authRepository = MockAuthRepository();
    RegisterUseCase registerUseCase =
        RegisterUseCase(authRepository: authRepository);
    AppUserEntity appUserEntity = AppUserEntity(
        username: "username",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        phone: "phone");
    var mockedResult = Success<AppUserEntity>(date: appUserEntity);
    provideDummy<Result<AppUserEntity>>(mockedResult);
    when(authRepository.register(registerRequest: registerRequest)).thenAnswer(
      (realInvocation) async => mockedResult,
    );

    var actual = await registerUseCase.invoke(registerRequest: registerRequest);
    expect(actual, isA<Success<AppUserEntity>>());
  });
}
