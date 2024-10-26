import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';
import '../utils/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color? borderColor;
  final double borderRadius;
  final double padding;
  final bool isOutlined;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.mainColor,
    this.borderColor, // Optional: defaults to `color` if not provided
    this.borderRadius = AppSize.s12,
    this.padding = 16.0,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? color : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isOutlined
                ? BorderSide(color: borderColor ?? color, width: 2.0)
                : BorderSide.none,
          ),
          padding: EdgeInsets.all(padding),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isOutlined ? borderColor ?? color : Colors.white,
            fontSize: AppSize.s18,
          ),
        ),
      ),
    );
  }
}
