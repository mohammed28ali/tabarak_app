import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/utils/constants.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign? align;
  final double? height;
  final TextDirection? textDirection;
  final int? lines;
  final TextOverflow? textOverFlow;
  final TextDecoration? textDecoration;
  final Color? decorationColor;

  const CustomText(
      {super.key,
      this.lines,
      this.textDirection,
      this.height,
      this.align,
      required this.text,
      this.color,
      this.fontSize,
      this.textDecoration,
      this.fontWeight = FontWeight.normal,
      this.textOverFlow,
      this.decorationColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textDirection: textDirection,
      softWrap: true,
      style: TextStyle(
        decoration: textDecoration ?? TextDecoration.none,
        height: height,
        decorationColor: decorationColor ?? Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: AppConstant.fontFamily,
        color: color ?? AppColors.mainColor,
        overflow: textOverFlow,
      ),
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
      textAlign: align ?? TextAlign.center,
    );
  }
}
