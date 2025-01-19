import 'package:flutter/material.dart';
import '../../../../core/utils/functions/spaceing/spaceing.dart';
import 'logout_button_widget.dart';
import 'profile_form_field_widget.dart';
import 'update_profile_button_widget.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const ProfileFormFieldWidget(),
            verticalSpace(24),
            const UpdateProfileButtonWidget(),
            verticalSpace(10),
            const LogoutButtonWidget(),
          ],
        ),
      ),
    );
  }
}
