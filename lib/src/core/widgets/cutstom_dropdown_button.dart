import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<DropdownMenuItem<String>> items; // Accept DropdownMenuItem list
  final String hintText;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  CustomDropdownButton({
    Key? key,
    required this.items,
    required this.hintText,
    this.selectedValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: AppColors.textFormFiledBorderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
              color: AppColors.textFormFiledBorderColor, width: 2),
        ),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
      value: selectedValue,
      items: items, // Now accepts DropdownMenuItem list
      onChanged: onChanged,
    );
  }
}
