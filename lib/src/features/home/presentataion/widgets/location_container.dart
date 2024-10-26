import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/utils/app_strings.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';

class LocationContainer extends StatelessWidget {
  const LocationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      color: AppColors.redSoftLocationContainerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_off_rounded,
                color: AppColors.whiteColor,
              ),
              CustomText(
                text: AppStrings.locationNotDetect,
                color: AppColors.whiteColor,
                fontSize: context.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            width: context.width * 0.5,
            height: context.height * 0.07,
            child: CommonButton(
              color: AppColors.redSoftLocationContainerColor,
              text: AppStrings.openLocationSettings,
              isOutlined: true,
              borderColor: AppColors.whiteColor,
              onPressed: () async {
                PermissionStatus status = await Permission.location.request();

                if (status.isGranted) {
                  openLocationSettings();
                } else if (status.isDenied) {
                } else if (status.isPermanentlyDenied) {
                  openAppSettings();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void openLocationSettings() async {
    bool serviceEnabled;
    Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    if (Platform.isAndroid) {
    } else {}
  }
}
