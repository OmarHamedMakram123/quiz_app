import 'package:injectable/injectable.dart';
import '../../entities/app_user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../data/model/request/login_request.dart';

@injectable
class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});
  Future<Result<AppUserEntity>> invoke(
      {required LoginRequest loginRequest}) {
    return authRepository.login(loginRequest: loginRequest);
  }
}
