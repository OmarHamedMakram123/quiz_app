import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../data/model/request/verify_reset_code_request.dart';
import '../../entities/success_auth_entity.dart';
import '../../repositories/auth_repository.dart';
@injectable
class VerifyResetCodeUseCase{
  final AuthRepository authRepository;
  VerifyResetCodeUseCase({required this.authRepository});
  Future<Result<SuccessAuthEntity>>invoke({required VerifyResetCodeRequest verifyResetCodeRequest})async{
    return authRepository.verifyResetCode(verifyRestCode: verifyResetCodeRequest);
  }
}