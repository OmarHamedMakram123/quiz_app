import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../repositories/auth_repository.dart';
@injectable
class LogoutUseCase{
  final AuthRepository authRepository;
  LogoutUseCase({required this.authRepository});
  Future<Result<bool>>invoke()async{
    return authRepository.logOut();
  }
}