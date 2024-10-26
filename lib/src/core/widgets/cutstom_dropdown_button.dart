import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String hintText;

  CustomDropdownButton({
    Key? key,
    required this.items,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: AppColors.textFormFiledBorderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: AppColors.textFormFiledBorderColor, width: 2),
        ),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16),
                ),
              ))
          .toList(),
      onChanged: (value) {
        // Handle change
      },
    );
  }
}
