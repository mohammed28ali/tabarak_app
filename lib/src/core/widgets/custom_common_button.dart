import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';

import '../utils/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double padding;

  const CommonButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.mainColor,
    this.borderRadius = AppSize.s24,
    this.padding = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.all(padding),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: AppSize.s18),
        ),
      ),
    );
  }
}
