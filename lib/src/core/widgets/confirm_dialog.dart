import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';
import 'package:tabark_innov8/src/features/authentication/signup/presentation/screens/signup_screen.dart';

import '../utils/app_strings.dart';

class ConfirmDialogPopup extends StatelessWidget {
  final String text;
  final String cofirmButtonText;
  final String logoPath;
  final VoidCallback onConfirm;

  const ConfirmDialogPopup({
    Key? key,
    required this.text,
    required this.logoPath,
    required this.onConfirm,
    required this.cofirmButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 4),
      backgroundColor: AppColors.whiteColor,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close))),
          SvgPicture.asset(
            logoPath,
            height: context.width * 0.15,
          ),
          (context.height * 0.015).emptyBoxHeight,
          CustomText(
            text: text,
            color: Colors.black,
            fontSize: context.width * 0.05,
          ),
          (context.height * 0.04).emptyBoxHeight,
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  text: cofirmButtonText,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                ),
              ),
              (context.width * 0.013).emptyBoxWidth,
              Expanded(
                child: CommonButton(
                  text: AppStrings.close,
                  onPressed: () => context.pop(),
                  color: AppColors.whiteColor,
                  isOutlined: true,
                  borderColor: AppColors.greyColor,
                ),
              ),
            ],
          )
        ],
      ),
      actions: [],
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String text,
    required String cofirmButtonText,
    required String logoPath,
    required VoidCallback onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return ConfirmDialogPopup(
          text: text,
          logoPath: logoPath,
          onConfirm: onConfirm,
          cofirmButtonText: cofirmButtonText,
        );
      },
    );
  }
}
