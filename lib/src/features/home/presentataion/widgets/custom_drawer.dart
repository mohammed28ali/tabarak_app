import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabark_innov8/src/config/dependency_injection/dependency_injection.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/utils/app_strings.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';
import 'package:tabark_innov8/src/core/widgets/logo_widget.dart';
import 'package:tabark_innov8/src/features/home/presentataion/bussines_logic/cubit.dart';
import 'package:tabark_innov8/src/features/home/presentataion/bussines_logic/state.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitched = prefs.getBool(EndPoints.enableNotification) ?? false;
    });
  }

  Future<void> _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(EndPoints.enableNotification, value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CheckInCheckOutCubit>(),
      child: Drawer(
        width: context.width * 0.7,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            (context.height * 0.02).emptyBoxHeight,
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            LogoWidget(
              height: context.height * 0.2,
              width: context.height * 0.2,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: AppStrings.receiveNotifications,
                  color: AppColors.darkGreyColor2,
                ),
                BlocBuilder<CheckInCheckOutCubit, CheckInCheckOutState>(
                  builder: (context, state) {
                    return Switch(
                      inactiveTrackColor: AppColors.greyColor,
                      activeColor: AppColors.mainColor,
                      trackOutlineColor:
                          MaterialStateProperty.all(Colors.transparent),
                      thumbColor: MaterialStateProperty.all(Colors.white),
                      value: _isSwitched,
                      onChanged: (value) {
                        setState(() {
                          _isSwitched = value;
                        });
                        _saveSwitchState(value);
                        context
                            .read<CheckInCheckOutCubit>()
                            .enableNotification(value);
                      },
                    );
                  },
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
