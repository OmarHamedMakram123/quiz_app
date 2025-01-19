import 'package:injectable/injectable.dart';
import '../../../data/model/request/register_request.dart';
import '../../entities/app_user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../../core/api/common/api_result.dart';

@injectable
class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});
  Future<Result<AppUserEntity>> invoke(
      {required RegisterRequest registerRequest}) {
    return authRepository.register(registerRequest: registerRequest);
  }
}
