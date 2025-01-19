import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/core/extension/extension.dart';
import '../../../../config/routes/page_route_name.dart';
import '../../../../core/utils/dialogs/awesome_dialoge.dart';
import '../../../../core/utils/dialogs/loading_dialog.dart';
import '../../../../dependency_injection/di.dart';
import '../view_model/verify_reset_code_action.dart';
import '../view_model/verify_reset_code_cubit.dart';
import '../widget/verify_reset_code_body.dart';

class VerifyResetCodeView extends StatefulWidget {
  const VerifyResetCodeView({super.key});

  @override
  State<VerifyResetCodeView> createState() => _VerifyResetCodeViewState();
}


class _VerifyResetCodeViewState extends State<VerifyResetCodeView> {
  var verifyResetCodeViewMode = getIt.get<VerifyResetCodeCubit>();

  @override
  Widget build(BuildContext context) {
    verifyResetCodeViewMode.email=ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider(
      create: (context) => verifyResetCodeViewMode,
      child: BlocListener<VerifyResetCodeCubit, VerifyResetCodeState>(
        listener: (context, state) =>_handleBlocListerVerifyResetCodeState(state),
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.localizations.password),
          ),
          body: const VerifyResetCodeBody(),
        ),
      ),
    );
  }


  dynamic _handleBlocListerVerifyResetCodeState(VerifyResetCodeState state) {
    if (state is VerifyCodeLoadingStata) {
      LoadingDialog.show(context);
    } else if (state is VerifyCodeErrorStata) {
      LoadingDialog.hide(context);
      showAwesomeDialog(
        context,
        title: context.localizations.error,
        desc: state.errorMassage.toString(),
        onOk: () {},
        dialogType: DialogType.error,
      );
    } else if (state is VerifyCodeSuccessStata) {
      LoadingDialog.hide(context);
      showAwesomeDialog(
        context,
        title: context.localizations.success,
        dismiss: false,
        desc: state.massage ?? "",
        onOk: () =>verifyResetCodeViewMode.doAction(
            NavigateToResetPasswordAction()
        ),
        dialogType: DialogType.success,
      );

    } else if (state is NavigateToResetPasswordScreenState) {
     return  _navigateToResetPasswordScreen();
    }
  }

  void _navigateToResetPasswordScreen() {
    Navigator.pushNamed(context, PageRouteName.resetPassword,arguments:verifyResetCodeViewMode.email);
}

}
