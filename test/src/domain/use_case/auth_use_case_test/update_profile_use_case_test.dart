import 'package:mockito/mockito.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/src/data/model/request/update_profile_request.dart';
import 'package:quize_app/src/data/model/response/app_user_model/app_user_model.dart';
import 'package:quize_app/src/domain/entities/app_user_entity.dart';
import 'package:quize_app/src/domain/repositories/auth_repository.dart';
import 'package:quize_app/src/domain/use_case/auth_use_case/edit_profile_use_case.dart';
import 'package:test/test.dart';

import '../mocked/moked_repository.mocks.dart';

void main() {
  test('should return Success<AppUserEntity> when call auhRepository.updateProfile is Successfully', () async{
    UpdateProfileRequest updateProfileRequest=UpdateProfileRequest(username: "username", firstName: "firstName", lastName: "lastName", email: "email", phone: "phone");
    AppUserEntity appUserEntity=AppUserEntity(username: "username", firstName: "firstName", lastName: "lastName", email: "email", phone: "phone");
    var mockedResult=Success<AppUserEntity>(date: appUserEntity);
    provideDummy<Result<AppUserEntity>>(mockedResult);
    AuthRepository authRepository=MockAuthRepository();
    EditProfileUseCase updateProfileUseCase=EditProfileUseCase(authRepository: authRepository);
    when(authRepository.updateProfile(updateProfileRequest: updateProfileRequest)).thenAnswer((realInvocation) async=> mockedResult,);
    var actual=await updateProfileUseCase.invoke(updateProfileRequest: updateProfileRequest);
    expect(actual, isA<Success<AppUserEntity>>());
  });
}