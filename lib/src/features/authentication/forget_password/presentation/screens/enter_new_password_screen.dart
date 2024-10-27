import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';

import '../../../../../config/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_values.dart';
import '../../../../../core/widgets/custom_common_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class EnterNewPasswordScreen extends StatelessWidget {
  EnterNewPasswordScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
          text: AppStrings.changePassword,
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
                    text: AppStrings.writeNewPassword,
                    fontSize: AppSize.s20,
                    color: AppColors.darkGreyColor2,
                  ),
                  (context.height * 0.025).emptyBoxHeight,
                  CustomTextField(
                    controller: passwordController,
                    hasPrefix: true,
                    hintText: AppStrings.password,
                    prefixIcon: SvgPicture.asset(
                      AppImages.lockIcon,
                      height: context.height * 0.005,
                      width: context.width * 0.005,
                      fit: BoxFit.contain,
                    ),
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: Icon(
                        PhosphorIcons.eye_slash,
                        size: context.width * 0.09,
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                    obscure: true,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterPassword;
                      }
                      return null;
                    },
                  ),
                  (context.height * 0.025).emptyBoxHeight,
                  CustomTextField(
                    controller: confirmPasswordController,
                    hasPrefix: true,
                    hintText: AppStrings.confirmPassword,
                    prefixIcon: SvgPicture.asset(
                      AppImages.lockIcon,
                      height: context.height * 0.005,
                      width: context.width * 0.005,
                      fit: BoxFit.contain,
                    ),
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: Icon(
                        PhosphorIcons.eye_slash,
                        size: context.width * 0.09,
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                    obscure: true,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterConfirmPassword;
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        return AppStrings.passwordsDonotMatch;
                      }
                      return null;
                    },
                  ),
                  (context.height * 0.025).emptyBoxHeight,
                  CommonButton(
                    text: AppStrings.confirm,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.pushNamed(Routes.signinScreen);
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
