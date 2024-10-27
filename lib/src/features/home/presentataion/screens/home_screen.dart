import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabark_innov8/src/config/routes/app_route.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/toast_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/utils/app_strings.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';
import 'package:tabark_innov8/src/core/widgets/confirm_dialog.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';
import 'package:tabark_innov8/src/core/widgets/logo_widget.dart';
import 'package:tabark_innov8/src/features/home/domain/model/model.dart';
import 'package:tabark_innov8/src/features/home/presentataion/bussines_logic/state.dart';
import 'package:tabark_innov8/src/features/home/presentataion/widgets/custom_drawer.dart';
import 'package:tabark_innov8/src/features/home/presentataion/widgets/home_grid_item_widget.dart';
import 'package:tabark_innov8/src/features/home/presentataion/widgets/location_container.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/widgets/success_dialog.dart';
import '../bussines_logic/cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _performCheckIn(BuildContext context) async {
    final image = await _captureImage();
    if (image == null) return;

    final deviceId = await _getDeviceId();
    final position = await _getCurrentLocation();

    if (position != null) {
      context.read<CheckInCheckOutCubit>().checkIn(
            LocationData(
              photo: image,
              udid: deviceId,
              latitude: position.latitude,
              longitude: position.longitude,
            ),
          );
    } else {}
  }

  Future<void> _performCheckOut(BuildContext context) async {
    final image = await _captureImage();
    if (image == null) return;

    final deviceId = await _getDeviceId();
    final position = await _getCurrentLocation();

    if (position != null) {
      context.read<CheckInCheckOutCubit>().checkOut(
            LocationData(
              photo: image,
              udid: deviceId,
              latitude: position.latitude,
              longitude: position.longitude,
            ),
          );
    } else {}
  }

  Future<File?> _captureImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      return File(image.path);
    }

    return null;
  }

  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id ?? 'unknown_device_id';
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      GridItemData(
        title: AppStrings.checkIn,
        color: AppColors.blueContainerColor,
        icon: AppImages.loginIcon,
        onTap: () => ConfirmDialogPopup.show(
          context,
          text: AppStrings.makeSureToRegisterYourAttendance,
          cofirmButtonText: AppStrings.checkIn,
          logoPath: AppImages.blackLoginIcon,
          onConfirm: () => _performCheckIn(context),
        ),
      ),
      GridItemData(
        title: AppStrings.checkOut,
        color: AppColors.redContainerColor,
        icon: AppImages.logoutIcon,
        onTap: () => ConfirmDialogPopup.show(
          context,
          text: AppStrings.makesurCheckOut,
          cofirmButtonText: AppStrings.checkOut,
          logoPath: AppImages.blackLogoutIcon,
          onConfirm: () => _performCheckOut(context),
        ),
      ),
      GridItemData(
        title: AppStrings.addMission,
        color: AppColors.greenSoftContainerColor,
        icon: AppImages.addIcon,
        onTap: () => context.pushNamed(Routes.addMission),
      ),
      GridItemData(
        title: AppStrings.showMissions,
        color: AppColors.greenContainerColor,
        icon: AppImages.listIcon,
        onTap: () => context.pushNamed(Routes.viewMission),
      ),
    ];

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const CustomText(
          text: 'مرحبأ',
          fontSize: 20,
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: const LocationContainer(),
      body: BlocConsumer<CheckInCheckOutCubit, CheckInCheckOutState>(
        listener: (context, state) {
          if (state is CheckInSuccessState) {
            showDialog(
              context: context,
              builder: (context) => const SuccessDialogPopup(
                text: AppStrings.checkInSuccess,
              ),
            );
          } else if (state is CheckOutSuccessState) {
            showDialog(
              context: context,
              builder: (context) => const SuccessDialogPopup(
                text: AppStrings.checkOutSuccess,
              ),
            );
          } else if (state is CheckInFailureState ||
              state is CheckOutFailureState ||
              state is EnableNotificationFailureState) {
            context.errorSnackBar(AppStrings.noRouteFound, 2);
          }
        },
        builder: (context, state) {
          return state is LoadingState
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSize.s20),
                      child: Column(
                        children: [
                          LogoWidget(
                              height: context.height * 0.2,
                              width: context.width * 0.3),
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return HomeGridItemWidget(item: items[index]);
                            },
                          ),
                          (context.height * 0.1).emptyBoxHeight,
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                              context.pushAndRemoveNamed(Routes.signinScreen);
                            },
                            child: const CustomText(
                              text: AppStrings.logout,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
