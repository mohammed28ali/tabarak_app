import 'package:flutter/material.dart';
import 'package:tabark_innov8/app.dart';
import 'package:tabark_innov8/src/config/dependency_injection/dependency_injection.dart'
    as di;

void main() async {
  await di.init();

  runApp(const TabarakApp());
}
