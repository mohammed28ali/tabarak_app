import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabark_innov8/src/config/routes/app_route.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/utils/app_images.dart';
import 'package:tabark_innov8/src/core/utils/app_strings.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';
import 'package:tabark_innov8/src/core/utils/constants.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text_field.dart';
import 'package:tabark_innov8/src/core/widgets/logo_widget.dart';
import 'package:tabark_innov8/src/features/authentication/signin/domain/entity/entity.dart';
import 'package:tabark_innov8/src/features/authentication/signin/presentation/business_logic/cubit.dart';
import 'package:tabark_innov8/src/features/authentication/signin/presentation/business_logic/state.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LogoWidget(
                height: context.height * 0.4,
                width: context.width * 0.4,
              ),
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
                    return 'Please enter your username or email';
                  }
                  return null;
                },
              ),
              (context.height * 0.025).emptyBoxHeight,
              CustomTextField(
                controller: _passwordController,
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
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              (context.height * 0.025).emptyBoxHeight,
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    context.pushNamed(Routes.homeScreen);
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const CircularProgressIndicator();
                  }
                  return CommonButton(
                    text: AppStrings.signin,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        const notificationKey = AppConstant.notificationKey;

                        context.read<LoginCubit>().login(
                              LoginUser(
                                username: username,
                                password: password,
                                notificationKey: notificationKey,
                              ),
                            );
                      }
                    },
                  );
                },
              ),
              (context.height * 0.025).emptyBoxHeight,
              CommonButton(
                text: AppStrings.purchase,
                isOutlined: true,
                borderColor: AppColors.mainColor,
                color: AppColors.whiteColor,
                onPressed: () {
                  context.pushNamed(Routes.signupScreen);
                },
              ),
              (context.height * 0.025).emptyBoxHeight,
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.forgetPasswordScreen);
                },
                child: const CustomText(
                  text: AppStrings.forgetPassword,
                  color: AppColors.darkGreyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
