import 'package:injectable/injectable.dart';
import 'package:quize_app/core/api/common/api_result.dart';
import 'package:quize_app/core/api/common/execute_api_method.dart';
import 'package:quize_app/src/data/data_source/online_data_source/auth_data_source/auth_online_data_source.dart';
import 'package:quize_app/src/data/mappers/auth_mapper.dart';
import 'package:quize_app/src/data/model/request/change_password_request.dart';
import 'package:quize_app/src/data/model/request/forget_password_request.dart';
import 'package:quize_app/src/data/model/request/register_request.dart';
import 'package:quize_app/src/data/model/request/reset_password_request.dart';
import 'package:quize_app/src/data/model/request/update_profile_request.dart';
import 'package:quize_app/src/data/model/request/verify_reset_code_request.dart';
import 'package:quize_app/src/data/model/response/forget_password_response/forget_password_response_model.dart';
import 'package:quize_app/src/domain/entities/app_user_entity.dart';
import 'package:quize_app/src/domain/entities/success_auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_source/offline_data_source/auth_offline_data_source/auth_offline_data_source.dart';
import '../model/request/login_request.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthOnlineDataSource authOnlineDataSource;
  final AuthOfflineDataSource authOfflineDataSource;
  final AuthMapper authMapper;
  AuthRepositoryImpl(
      this.authOfflineDataSource, this.authOnlineDataSource, this.authMapper);
  @override
  Future<Result<AppUserEntity>> login(
      {required LoginRequest loginRequest}) async {
    return await executeApi(
      apiCall: () async {
        var appUserModel = await authOnlineDataSource.login(loginRequest);
        authOfflineDataSource.saveToken(token: appUserModel.token);
        return authMapper.toAppUserModel(appUserModel);
      },
    );
  }

  @override
  Future<Result<AppUserEntity>> register(
      {required RegisterRequest registerRequest}) async {
    return await executeApi(
      apiCall: () async {
        var appUserModel = await authOnlineDataSource.register(registerRequest);
        authOfflineDataSource.saveToken(token: appUserModel.token);
        return authMapper.toAppUserModel(appUserModel);
      },
    );
  }

  @override
  Future<Result<AppUserEntity>> getProfileData() async {
    return executeApi<AppUserEntity>(
      apiCall: () async {
        var appUserModel = await authOnlineDataSource.getProfileDate();
        return authMapper.toAppUserModel(appUserModel);
      },
    );
  }

  @override
  Future<Result<bool>> changePassword(
      {required ChangePasswordRequest changePasswordRequest}) async {
    return executeApi<bool>(
      apiCall: () async {
        var successResponseModel = await authOnlineDataSource.changePassword(
            changePasswordRequest: changePasswordRequest);
        authOfflineDataSource.saveToken(token: successResponseModel.token);
        return Future.value(true);
      },
    );
  }

  @override
  Future<Result<AppUserEntity>> updateProfile(
      {required UpdateProfileRequest updateProfileRequest}) {
    return executeApi<AppUserEntity>(
      apiCall: () async {
        var appUserModel = await authOnlineDataSource.updateProfile(
            updateProfileRequest: updateProfileRequest);
        return authMapper.toAppUserModel(appUserModel);
      },
    );
  }

  @override
  Future<Result<SuccessAuthEntity>> forgetPassword(
      {required ForgetPasswordRequest forgetPasswordRequest}) async {
    return await executeApi<SuccessAuthEntity>(
      apiCall: () async {
        ForgetPasswordResponseModel forgetPasswordResponseModel =
            await authOnlineDataSource.forgetPassword(
                forgetPasswordRequest: forgetPasswordRequest);
        return authMapper
            .toForgetPasswordResponseModel(forgetPasswordResponseModel);
      },
    );
  }

  @override
  Future<Result<bool>> logOut() async {
    return await executeApi(apiCall: () async {
      var massage = await authOnlineDataSource.logOut();
      await authOfflineDataSource.deleteToken();
      return Future.value(true);
    });
  }

  @override
  Future<Result<SuccessAuthEntity>> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest}) async {
    return executeApi(
      apiCall: () async {
        var successResponseModel = await authOnlineDataSource.resetPassword(
            resetPasswordRequest: resetPasswordRequest);
        authOfflineDataSource.saveToken(token: successResponseModel.token);
        return authMapper.toSuccessAuthResponseModel(successResponseModel);
      },
    );
  }

  @override
  Future<Result<SuccessAuthEntity>> verifyResetCode(
      {required VerifyResetCodeRequest verifyRestCode}) {
    return executeApi(
      apiCall: () async {
        var successResponseModel = await authOnlineDataSource.verifyResetCode(
            verifyRestCode: verifyRestCode);
        return authMapper.toSuccessAuthResponseModel(successResponseModel);
      },
    );
  }
}
