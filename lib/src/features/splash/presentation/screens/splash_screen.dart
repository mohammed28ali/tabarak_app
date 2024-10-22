import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tabark_innov8/src/config/routes/app_route.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/widgets/logo_widget.dart';
import 'package:tabark_innov8/src/features/splash/presentation/cubit/cubit.dart';
import 'package:tabark_innov8/src/features/splash/presentation/cubit/state.dart';
import 'package:tabark_innov8/src/config/dependency_injection/dependency_injection.dart'
    as di;

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SplashCubit>()..loadData(),
      child: Scaffold(
        backgroundColor: AppColors.splashBackGroundColor,
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) async {
            if (state == SplashState.loaded) {
              bool loggedIn = await isLoggedIn();
              if (loggedIn) {
                context.pushAndRemoveNamed(Routes.homeScreen);
              } else {
                context.pushAndRemoveNamed(Routes.loginScreen);
              }
            }
          },
          child: Center(
            child: LogoWidget(
              height: context.height * 0.5,
              width: context.width * 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
