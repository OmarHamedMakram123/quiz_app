import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/common/api_result.dart';
import '../../../../core/error/error_handler.dart';
import '../../../data/model/request/login_request.dart';
import '../../../domain/entities/app_user_entity.dart';
import '../../../domain/use_case/auth_use_case/login_use_case.dart';
import 'login_action.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> doAction(LoginAction loginActionView) async {
    switch (loginActionView) {
      case ButtonLoginAction():
        return await _login();
      case NavigateToForgetPasswordScreenAction():
        return _navigateToForgetPasswordScreen();
      case NavigateToBaseScreenAction():
        return _navigateToBaseScreen();
      case NavigateToRegisterScreenAction():
        return _navigateToRegisterScreen();
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState>formKey=GlobalKey<FormState>();


  Future<void> _login() async {
    emit(LoginLoadingState());
    LoginRequest loginRequest = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    var result = await loginUseCase.invoke(loginRequest: loginRequest);
    switch (result) {
      case Success<AppUserEntity>():
        emit(LoginSuccessState());
      case Failures<AppUserEntity>():
        emit(LoginFailuresState(
            errorMassage:
                ErrorHandler.formException(result.exception).errorMassage));
    }
  }

  void _navigateToRegisterScreen() {
    emit(NavigateToRegisterScreenState());
  }

  void _navigateToBaseScreen() {
    emit(NavigateToBaseScreenState());
  }

  void _navigateToForgetPasswordScreen() {
    emit(NavigateToForgetPasswordScreenState());
  }
}
