import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../entities/app_user_entity.dart';
import '../../repositories/auth_repository.dart';

@injectable
class GetProfileDataUseCase{
  final AuthRepository authRepository;
  GetProfileDataUseCase({required this.authRepository});

 Future<Result<AppUserEntity>>invoke()async{
   return authRepository.getProfileData();
 }
}