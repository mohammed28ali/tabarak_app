import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/widgets/custom_text.dart';

class ViewMissionScreen extends StatelessWidget {
  const ViewMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          text: '${AppStrings.missions} (2)',
          color: Colors.black,
          fontSize: AppSize.s20,
        ),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          SizedBox(
              width: 100,
              height: 50,
              child: CommonButton(
                  text: AppStrings.update,
                  isOutlined: true,
                  borderColor: AppColors.mainColor,
                  color: AppColors.whiteColor,
                  onPressed: () {}))
        ],
      ),
      body: Column(
        children: [
          Divider(),
          Container(
            child: Column(
              children: [
                CustomText(text: 'تاريخ المأمورية'),
                CustomText(text: '23-10-2023 1 ظهراً  - 23-10-2023 1 ظهراً '),
                Divider(),
                CustomText(
                    text:
                        'النوع : استخراج تصاريح الحفر لمشروع النقل والهندس..'),
                CustomText(text: 'السبب : شراء أجهزة كمبيوتر'),
                Row(
                  children: [
                    Expanded(
                        child: CommonButton(text: 'دخول', onPressed: () {})),
                    Expanded(
                        child: CommonButton(text: 'خروج', onPressed: () {})),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
