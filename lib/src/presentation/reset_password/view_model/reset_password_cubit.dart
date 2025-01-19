import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/common/api_result.dart';
import '../../../../core/error/error_handler.dart';
import '../../../data/model/request/reset_password_request.dart';
import '../../../domain/entities/success_auth_entity.dart';
import '../../../domain/use_case/auth_use_case/reset_password_use_case.dart';
import 'reset_password_action.dart';

part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordCubit(this._resetPasswordUseCase)
      : super(ResetPasswordInitial());

  Future<void> doAction(ResetPasswordAction resetPasswordAction) async {
    switch (resetPasswordAction) {
      case ResetPasswordContinueButtonPressedAction():
        return await _resetPassword();
      case NavigateToBaseMainScreenAction():
        return _navigateToBaseScreenCode();
    }
  }

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState>formKey=GlobalKey<FormState>();
  String email="";
  Future<void> _resetPassword() async {
    emit(ResetPasswordLoadingStata());
    ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(
        email: email, newPassword: newPassword.text);
    var result = await _resetPasswordUseCase.invoke(
        resetPasswordRequest: resetPasswordRequest);
    switch (result) {
      case Success<SuccessAuthEntity>():
        emit(ResetPasswordSuccessStata(
            massage: result.date.massage ?? "success"));
      case Failures<SuccessAuthEntity>():
        final errorModel = ErrorHandler.formException(result.exception);
        emit(ResetPasswordErrorStata(errorMassage: errorModel.errorMassage));
    }
  }

  void _navigateToBaseScreenCode() {
    emit(NavigateToBaseScreenState());
  }
}
