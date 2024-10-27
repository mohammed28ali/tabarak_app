import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';

import '../utils/app_images.dart';

class SuccessDialogPopup extends StatelessWidget {
  final String text;

  const SuccessDialogPopup({
    Key? key,
    required this.text,
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
            AppImages.successIcon,
            height: context.width * 0.35,
          ),
          CustomText(
            text: text,
            color: Colors.black,
            fontSize: 20,
          )
        ],
      ),
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
        return SuccessDialogPopup(
          text: text,
        );
      },
    );
  }
}
