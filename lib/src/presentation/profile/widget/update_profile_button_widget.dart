import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize_app/core/extension/extension.dart';
import 'package:quize_app/src/presentation/profile/view_model/profile_action.dart';

import '../../../../core/utils/widget/custom_button_widget.dart';
import '../view_model/profile_cubit.dart';

class UpdateProfileButtonWidget extends StatelessWidget {
  const UpdateProfileButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var profileViewModel = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomButtonWidget(
          text: context.localizations.update,
          cheekBackGroundColor: profileViewModel.isFormField,
          onPressed: () {
            if (profileViewModel.formKey.currentState!.validate() &&
                profileViewModel.isFormField == true) {
              profileViewModel.doAction(UpdateProfileButtonAction());

            }
          },
        );
      },
    );
  }
}
