import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../data/model/request/change_password_request.dart';
import '../../repositories/auth_repository.dart';

@injectable
class ChangePasswordUseCase{
  final AuthRepository authRepository;
  ChangePasswordUseCase({required this.authRepository});

  Future<Result<bool>>invoke({required ChangePasswordRequest changePasswordRequest})async{
    return await  authRepository.changePassword(changePasswordRequest: changePasswordRequest);
  }
}