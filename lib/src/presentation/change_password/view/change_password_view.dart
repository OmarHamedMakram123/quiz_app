import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/config/routes/page_route_name.dart';
import 'package:quize_app/core/extension/extension.dart';
import 'package:quize_app/src/presentation/change_password/view_model/change_password_cubit.dart';
import '../../../../core/utils/dialogs/awesome_dialoge.dart';
import '../../../../core/utils/dialogs/loading_dialog.dart';
import '../widget/change_password_body.dart';
import '../../../../dependency_injection/di.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  var changePasswordViewModel = getIt.get<ChangePasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => changePasswordViewModel,
        child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) => _handleBlocListenerState(state),
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.localizations.resetPassword),
            ),
            body: const ChangePasswordBody(),
          ),
        ));
  }

  void _handleBlocListenerState(ChangePasswordState state) {
    if (state is ChangePasswordLoadingState) {
      LoadingDialog.show(context);
    } else if (state is ChangePasswordFailuresState) {
      LoadingDialog.hide(context);
      showAwesomeDialog(
        context,
        title: context.localizations.connectionError,
        desc: state.errorModel.errorMassage.toString(),
        onOk: () {},
        dialogType: DialogType.error,
      );
    } else if (state is ChangePasswordSuccessState) {
      LoadingDialog.hide(context);
      showAwesomeDialog(
        dismiss: false,
        context,
        desc: "Change Password Successfully",
        title: "Success",
        onOk: () => Navigator.pushNamedAndRemoveUntil(
          context,
          PageRouteName.baseScreen,
          (route) => false,
        ),
        dialogType: DialogType.success,
      );
    }
  }
}
