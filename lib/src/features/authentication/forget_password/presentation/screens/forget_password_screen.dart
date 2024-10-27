import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_images.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text_field.dart';

import '../../../../../config/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_values.dart';
import '../../../../../core/widgets/custom_common_button.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../business_logic/forget_password_cubit/orget_password_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.darkGreyColor2,
          ),
        ),
        title: const CustomText(
          text: AppStrings.forgetPassword,
          fontSize: AppSize.s20,
          color: AppColors.darkGreyColor2,
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: AppStrings.writeEmailAndSendCode,
                    fontSize: AppSize.s16,
                    color: Colors.black,
                  ),
                  (context.height * 0.025).emptyBoxHeight,
                  CustomTextField(
                    controller: _usernameController,
                    hasPrefix: true,
                    hintText: AppStrings.emailAndUserName,
                    prefixIcon: SvgPicture.asset(
                      AppImages.emailIcon,
                      height: context.height * 0.005,
                      width: context.width * 0.005,
                      fit: BoxFit.contain,
                    ),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterUsernameOrEmail;
                      }
                      return null;
                    },
                  ),
                  (context.height * 0.025).emptyBoxHeight,
                  CommonButton(
                    text: AppStrings.next,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<ForgetPasswordCubit>()
                            .forgetPassword(_usernameController.text);
                        context.pushNamed(Routes.verifyOtpScreen);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
