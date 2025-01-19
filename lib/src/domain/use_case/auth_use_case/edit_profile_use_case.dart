import 'package:injectable/injectable.dart';
import '../../../data/model/request/update_profile_request.dart';
import '../../entities/app_user_entity.dart';
import '../../repositories/auth_repository.dart';
import '../../../../core/api/common/api_result.dart';

@injectable
class  EditProfileUseCase {
  final AuthRepository authRepository;
  EditProfileUseCase({required this.authRepository});
  Future<Result<AppUserEntity>> invoke(
      {required UpdateProfileRequest updateProfileRequest}) {
    return authRepository.updateProfile(updateProfileRequest: updateProfileRequest);
  }
}
