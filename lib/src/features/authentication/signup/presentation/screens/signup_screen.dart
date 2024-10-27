import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/toast_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_strings.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text_field.dart';
import 'package:tabark_innov8/src/features/authentication/signup/presentation/bussince_logic/state.dart';

import '../../../../../config/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../bussince_logic/cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignupCubit>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          text: AppStrings.purchase,
          fontSize: AppSize.s20,
          color: AppColors.darkGreyColor2,
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            context.pushAndRemoveNamed(Routes.signinScreen);
          } else if (state is SignupFailure) {
            context.errorSnackBar(state.message, 2);
          }
        },
        builder: (context, state) {
          if (state is SignupLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(),
                  (context.height * 0.025).emptyBoxHeight,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s16),
                    child: Column(
                      children: [
                        CustomTextField(
                          hasPrefix: true,
                          hintText: AppStrings.name,
                          prefixIcon: SvgPicture.asset(
                            AppImages.userIcon,
                            height: context.height * 0.005,
                            width: context.width * 0.005,
                            fit: BoxFit.contain,
                          ),
                          onChanged: (value) => cubit.fullName = value,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.pleaseEnterYourName;
                            }
                            return null;
                          },
                        ),
                        (context.height * 0.025).emptyBoxHeight,
                        CustomTextField(
                          hasPrefix: true,
                          hintText: AppStrings.emailAndUserName,
                          onChanged: (value) => cubit.userName = value,
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
                        CustomTextField(
                          hasPrefix: true,
                          hintText: AppStrings.password,
                          onChanged: (value) => cubit.password = value,
                          prefixIcon: SvgPicture.asset(
                            AppImages.lockIcon,
                            height: context.height * 0.005,
                            width: context.width * 0.005,
                            fit: BoxFit.contain,
                          ),
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              cubit.togglePasswordVisibility();
                            },
                            icon: Icon(
                              cubit.showPassword
                                  ? PhosphorIcons.eye
                                  : PhosphorIcons.eye_slash,
                              size: context.width * 0.09,
                              color: AppColors.darkGreyColor,
                            ),
                          ),
                          obscure: !cubit.showPassword,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.pleaseEnterPassword;
                            }
                            return null;
                          },
                        ),
                        (context.height * 0.025).emptyBoxHeight,
                        CustomTextField(
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
                            onPressed: () {
                              cubit.toggleConfirmPasswordVisibility();
                            },
                            icon: Icon(
                              cubit.showConfirmPassword
                                  ? PhosphorIcons.eye
                                  : PhosphorIcons.eye_slash,
                              size: context.width * 0.09,
                              color: AppColors.darkGreyColor,
                            ),
                          ),
                          obscure: !cubit.showConfirmPassword,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.pleaseEnterConfirmPassword;
                            }
                            if (value != cubit.password) {
                              return AppStrings.passwordsDonotMatch;
                            }
                            return null;
                          },
                        ),
                        (context.height * 0.025).emptyBoxHeight,
                        CommonButton(
                          text: AppStrings.purchase,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.registerUser();
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
        },
      ),
    );
  }
}
