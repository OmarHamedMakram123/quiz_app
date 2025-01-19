import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quize_app/core/extension/extension.dart';
import '../../../../config/routes/page_route_name.dart';
import '../../../../core/utils/dialogs/awesome_dialoge.dart';
import '../../../../core/utils/dialogs/loading_dialog.dart';
import '../../../../dependency_injection/di.dart';
import '../view_model/login_action.dart';
import '../view_model/login_cubit.dart';
import '../widget/login_body_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var loginViewModel = getIt.get<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginViewModel,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          return _handleBlocListenerState(state);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.localizations.login),
          ),
          body: Padding(
              padding: EdgeInsets.all(16.r), child: const LoginBodyWidget()),
        ),
      ),
    );
  }

  void _handleBlocListenerState(LoginState state) {
    if (state is LoginLoadingState) {
      LoadingDialog.show(context);
    }
    else if (state is LoginFailuresState) {
      LoadingDialog.hide(context);
      showAwesomeDialog(
        context,
        title: "Error",
        desc: state.errorMassage.toString(),
        onOk: () {},
        dialogType: DialogType.error,
      );
    } else if (state is LoginSuccessState) {
      LoadingDialog.hide(context);
      loginViewModel.doAction(NavigateToBaseScreenAction());
    } else if (state is NavigateToForgetPasswordScreenState) {
      LoadingDialog.hide(context);
      _navigateToForgetPasswordScreen();
    } else if (state is NavigateToBaseScreenState) {
      LoadingDialog.hide(context);
      _navigateToBaseScreen();
    } else if (state is NavigateToRegisterScreenState) {
      _navigateToRegister();
    }
  }

  void _navigateToBaseScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRouteName.baseScreen,
      (route) => false,
    );
  }

  void _navigateToForgetPasswordScreen() {
    Navigator.pushNamed(context, PageRouteName.forgetPassword);
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, PageRouteName.register);
  }
}
