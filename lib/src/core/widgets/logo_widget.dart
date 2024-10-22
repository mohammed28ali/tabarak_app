import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabark_innov8/src/core/utils/app_images.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  final double width;

  const LogoWidget({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages.logo,
      height: height,
      width: width,
    );
  }
}
