import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';

import '../../../../../config/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_values.dart';
import '../../../../../core/widgets/custom_common_button.dart';
import '../../../../../core/widgets/custom_text.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final TextEditingController _otpController = TextEditingController();

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
          text: AppStrings.confirmCode,
          fontSize: AppSize.s20,
          color: AppColors.darkGreyColor2,
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: AppStrings.writeSentCode,
                  fontSize: AppSize.s16,
                  color: Colors.black,
                ),
                (context.height * 0.025).emptyBoxHeight,
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: _otpController,
                    length: 6,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) {
                      return value == '123456' ? null : AppStrings.pinIncorrect;
                    },
                    crossAxisAlignment: CrossAxisAlignment.end,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    defaultPinTheme: PinTheme(
                      width: context.width * 0.2,
                      height: context.height * 0.08,
                      textStyle: const TextStyle(color: Colors.black),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppColors.textFormFiledBorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                (context.height * 0.025).emptyBoxHeight,
                CommonButton(
                  text: AppStrings.confirm,
                  onPressed: () {
                    if (_otpController.text == '123456') {
                      context.pushNamed(Routes.enterNewPasswordScreen);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
