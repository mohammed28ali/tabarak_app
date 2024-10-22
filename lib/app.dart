import 'package:flutter/material.dart';
import 'package:tabark_innov8/src/config/routes/app_route.dart';
import 'package:tabark_innov8/src/config/theme/app_theme.dart';
import 'package:tabark_innov8/src/core/utils/app_strings.dart';

class TabarakApp extends StatelessWidget {
  const TabarakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGeneratRoute,
    );
  }
}
