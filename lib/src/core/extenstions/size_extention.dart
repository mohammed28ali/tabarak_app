import 'package:flutter/material.dart';

extension SizeMediaQuery on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  double get heightNavbar =>
      height * 0.085 + MediaQuery.of(this).padding.bottom;
  Orientation get orientation => MediaQuery.of(this).orientation;
}
