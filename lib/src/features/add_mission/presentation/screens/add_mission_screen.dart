import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text_field.dart';
import 'package:tabark_innov8/src/core/widgets/cutstom_dropdown_button.dart';

import '../../../../core/utils/app_strings.dart';

class AddMissionScreen extends StatelessWidget {
  const AddMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          text: AppStrings.addMission,
          color: Colors.black,
          fontSize: AppSize.s20,
        ),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          CustomText(
            text: AppStrings.missionType,
            color: Colors.black,
          ),
          CustomDropdownButton(
            items: ['Option 1', 'Option 2', 'Option 3'],
            hintText: 'Select an option',
          ),
          CustomText(
            text: AppStrings.missionDate,
            color: Colors.black,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: CustomTextField()),
                    Expanded(
                      child: CustomDropdownButton(
                        items: ['Option 1', 'Option 2', 'Option 3'],
                        hintText: 'Select an option',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: CustomTextField()),
                    Expanded(
                      child: CustomDropdownButton(
                        items: ['Option 1', 'Option 2', 'Option 3'],
                        hintText: 'Select an option',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomText(
            text: AppStrings.statement,
            color: Colors.black,
          ),
          CustomTextField(),
          CommonButton(text: AppStrings.add, onPressed: () {})
        ],
      ),
    );
  }
}
