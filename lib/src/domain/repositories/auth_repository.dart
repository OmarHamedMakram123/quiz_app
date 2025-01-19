import 'package:quize_app/src/data/model/request/change_password_request.dart';
import 'package:quize_app/src/data/model/request/register_request.dart';
import 'package:quize_app/src/data/model/request/update_profile_request.dart';
import 'package:quize_app/src/domain/entities/success_auth_entity.dart';

import '../../../core/api/common/api_result.dart';
import '../../data/model/request/forget_password_request.dart';
import '../../data/model/request/login_request.dart';
import '../../data/model/request/reset_password_request.dart';
import '../../data/model/request/verify_reset_code_request.dart';
import '../entities/app_user_entity.dart';

abstract class AuthRepository {
  Future<Result<AppUserEntity>> login({required LoginRequest loginRequest});
  Future<Result<AppUserEntity>> register(
      {required RegisterRequest registerRequest});

  Future<Result<AppUserEntity>> getProfileData();
  Future<Result<AppUserEntity>> updateProfile({
    required UpdateProfileRequest updateProfileRequest
});
  Future<Result<bool>> changePassword({required ChangePasswordRequest changePasswordRequest});
  Future<Result<SuccessAuthEntity>>forgetPassword({required ForgetPasswordRequest forgetPasswordRequest});
  Future<Result<SuccessAuthEntity>>resetPassword({required ResetPasswordRequest resetPasswordRequest});
  Future<Result<SuccessAuthEntity>>verifyResetCode({required VerifyResetCodeRequest verifyRestCode});
  Future<Result<bool>>logOut();
}
