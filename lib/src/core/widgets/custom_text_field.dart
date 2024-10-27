import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Color? hintTextColor;
  final String? labelText;
  final FormFieldSetter? onSaved;
  final FormFieldValidator? validate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final bool? readonly;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final bool hasPrefix;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {super.key,
      this.inputFormatters,
      this.hintText,
      this.onSaved,
      this.validate,
      this.obscure = false,
      this.prefixIcon,
      this.readonly = false,
      this.controller,
      this.labelText,
      this.hasPrefix = false,
      this.maxLines,
      this.suffixIcon,
      this.textAlign,
      this.keyboardType,
      this.onTap,
      this.onFieldSubmitted,
      this.onChanged,
      this.height,
      this.hintTextColor});
  // height: height ?? AppSize.s60,
  // decoration: BoxDecoration(
  // border: Border.all(color: AppColors.textFormFiledBorderColor),
  // color: AppColors.whiteColor,
  // borderRadius: BorderRadius.circular(AppSize.s12)),
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextFormField(
      inputFormatters: [
        ...?inputFormatters,
        ArabicToEnglishNumberFormatter(),
      ],
      maxLines: maxLines ?? 1,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscure,
      onSaved: onSaved,
      validator: validate,
      autofocus: false,
      onTap: onTap,
      readOnly: readonly!,
      keyboardType: keyboardType,
      textAlign: textAlign ?? TextAlign.start,
      obscuringCharacter: '*',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontSize: 10,
        ),
        prefixIcon: hasPrefix
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 10, left: 10),
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelStyle: TextStyle(color: hintTextColor ?? AppColors.hintColor),
        hintStyle: const TextStyle(color: AppColors.hintColor, fontSize: 15),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.only(
          right: 20,
          left: 20,
          top: suffixIcon == null
              ? context.height * 0.05
              : context.height * 0.05,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: const BorderSide(
            color: AppColors.textFormFiledBorderColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: const BorderSide(
            color: AppColors.textFormFiledBorderColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: const BorderSide(
            color: AppColors.textFormFiledBorderColor,
            width: 2.0,
          ),
        ),
      ),
    ));
  }
}

class ArabicToEnglishNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAllMapped(
      RegExp(r'[٠١٢٣٤٥٦٧٨٩]'),
      (Match match) {
        const arabicToEnglishMap = {
          '٠': '0',
          '١': '1',
          '٢': '2',
          '٣': '3',
          '٤': '4',
          '٥': '5',
          '٦': '6',
          '٧': '7',
          '٨': '8',
          '٩': '9',
        };
        return arabicToEnglishMap[match.group(0)!]!;
      },
    );

    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
    );
  }
}
