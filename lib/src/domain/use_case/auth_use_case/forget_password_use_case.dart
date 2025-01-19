import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../data/model/request/forget_password_request.dart';
import '../../entities/success_auth_entity.dart';
import '../../repositories/auth_repository.dart';

@injectable
class ForgetPasswordUseCase{
  final AuthRepository authRepository;
  ForgetPasswordUseCase({required this.authRepository});
  Future<Result<SuccessAuthEntity>>invoke({required ForgetPasswordRequest forgetPasswordRequest})async{
    return authRepository.forgetPassword(forgetPasswordRequest: forgetPasswordRequest);
  }
}