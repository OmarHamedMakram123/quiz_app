import 'package:flutter/material.dart';
import 'package:quize_app/core/extension/extension.dart';
import 'package:quize_app/src/presentation/reset_password/widget/submit_reset_password_widget.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/spaceing/spaceing.dart';
import 'reset_password_form_field_widget.dart';

class ResetPasswordBodyWidget extends StatelessWidget {
  const ResetPasswordBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.localizations.resetPassword,
              style: AppFonts.font18kBlack0Weight500FontInter,
            ),
            verticalSpace(16),
            Text(
              textAlign: TextAlign.center,
              context.localizations.titleResetPassword,
              style: AppFonts.font14GrayWeight400FontInter,
            ),
            verticalSpace(32),
            const ResetPasswordFormFieldWidget(),
      
            verticalSpace(40),
            const ContinueResetPasswordButtonWidget(),
          ],
        ),
      ),
    );
  }
}
