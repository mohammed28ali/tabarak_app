import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/widgets/confirm_dialog.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';
import 'package:tabark_innov8/src/features/view_mission/domain/Entity.dart';
import 'package:tabark_innov8/src/features/view_mission/presentation/business_logic/cubit.dart';
import 'package:tabark_innov8/src/features/view_mission/presentation/business_logic/state.dart';

import '../../../../config/dependency_injection/dependency_injection.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/success_dialog.dart';

class ViewMissionScreen extends StatefulWidget {
  const ViewMissionScreen({super.key});

  @override
  _ViewMissionScreenState createState() => _ViewMissionScreenState();
}

class _ViewMissionScreenState extends State<ViewMissionScreen> {
  late ScrollController _scrollController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    context.read<ViewMissionCubit>().fetchMissions(1);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final currentState = context.read<ViewMissionCubit>().state;
        if (currentState is MissionLoaded) {
          context
              .read<ViewMissionCubit>()
              .fetchMissions(currentState.currentPage + 1);
        }
      }
    });
  }

  Future<Position?> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<File?> _pickImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    return photo != null ? File(photo.path) : null; // Return the File object
  }

  Future<String?> _getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? uuid;

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final iOSInfo = await deviceInfo.iosInfo; // Get iOS device info
      uuid = iOSInfo.identifierForVendor; // Unique ID for iOS
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      final androidInfo =
          await deviceInfo.androidInfo; // Get Android device info
      uuid = androidInfo.id; // Unique ID for Android
    }

    return uuid;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ViewMissionCubit>()..fetchMissions(1),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: false,
          title: BlocBuilder<ViewMissionCubit, ViewMissionState>(
            builder: (context, state) {
              int missionCount = 0;
              if (state is MissionLoaded) {
                missionCount = state.missions.length;
              }
              return CustomText(
                text: '${AppStrings.missions} ($missionCount)',
                color: Colors.black,
                fontSize: AppSize.s20,
              );
            },
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                width: 100,
                height: 50,
                child: CommonButton(
                  text: AppStrings.update,
                  isOutlined: true,
                  borderColor: AppColors.mainColor,
                  color: AppColors.whiteColor,
                  onPressed: () {
                    context.read<ViewMissionCubit>().fetchMissions(1);
                  },
                ),
              ),
            )
          ],
        ),
        body: BlocConsumer<ViewMissionCubit, ViewMissionState>(
          listener: (context, state) {
            if (state is MissionCheckInSuccess) {
              showDialog(
                context: context,
                builder: (context) => const SuccessDialogPopup(
                  text: AppStrings.missionSuccessfullyLoggedIn,
                ),
              );
            } else if (state is MissionCheckOutSuccess) {
              showDialog(
                context: context,
                builder: (context) => const SuccessDialogPopup(
                  text: AppStrings.missionSuccessfullyLoggedOut,
                ),
              );
            }
          },
          builder: (context, state) {
            return BlocBuilder<ViewMissionCubit, ViewMissionState>(
              builder: (context, state) {
                if (state is MissionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MissionLoaded) {
                  final missions = state.missions;

                  return state is MissionLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const Divider(),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: missions.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final mission = missions[index];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors
                                                .textFormFiledBorderColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CustomText(
                                              text: AppStrings.missionDate,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                            (context.height * 0.015)
                                                .emptyBoxHeight,
                                            CustomText(
                                              text: mission.date,
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                            (context.height * 0.015)
                                                .emptyBoxHeight,
                                            const Divider(),
                                            (context.height * 0.015)
                                                .emptyBoxHeight,
                                            CustomText(
                                              fontSize: 18,
                                              color: Colors.black,
                                              text:
                                                  '${AppStrings.type} : ${mission.missionType}',
                                            ),
                                            (context.height * 0.015)
                                                .emptyBoxHeight,
                                            CustomText(
                                              fontSize: 18,
                                              color: Colors.black,
                                              text:
                                                  '${AppStrings.reasone} : ${mission.reason}',
                                            ),
                                            (context.height * 0.015)
                                                .emptyBoxHeight,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CommonButton(
                                                    icon: SvgPicture.asset(
                                                        AppImages
                                                            .whiteLoginIcon),
                                                    text: AppStrings.entry,
                                                    onPressed: () =>
                                                        ConfirmDialogPopup.show(
                                                      context,
                                                      text: AppStrings
                                                          .makeSureYouLogIntoMission,
                                                      cofirmButtonText:
                                                          AppStrings.checkIn,
                                                      logoPath: AppImages
                                                          .blackLoginIcon,
                                                      onConfirm: () async {
                                                        Position? position =
                                                            await _getCurrentLocation();
                                                        File? photoFile =
                                                            await _pickImage();
                                                        String? deviceId =
                                                            await _getDeviceId();

                                                        if (position != null &&
                                                            photoFile != null &&
                                                            deviceId != null) {
                                                          context
                                                              .read<
                                                                  ViewMissionCubit>()
                                                              .checkInMission(
                                                                MissionCheck(
                                                                  missionId:
                                                                      mission
                                                                          .id,
                                                                  latitude: position
                                                                      .latitude,
                                                                  longitude:
                                                                      position
                                                                          .longitude,
                                                                  photo:
                                                                      photoFile,
                                                                  udid:
                                                                      deviceId,
                                                                ),
                                                              );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: CommonButton(
                                                    icon: SvgPicture.asset(
                                                        AppImages
                                                            .whiteLogoutIcon),
                                                    color: AppColors
                                                        .redContainerColor,
                                                    text: AppStrings.exit,
                                                    onPressed: () =>
                                                        ConfirmDialogPopup.show(
                                                      context,
                                                      text: AppStrings
                                                          .makeSureYouLogOutMission,
                                                      cofirmButtonText:
                                                          AppStrings.checkOut,
                                                      logoPath: AppImages
                                                          .blackLogoutIcon,
                                                      onConfirm: () async {
                                                        Position? position =
                                                            await _getCurrentLocation();
                                                        File? photoFile =
                                                            await _pickImage();
                                                        String? deviceId =
                                                            await _getDeviceId();

                                                        if (position != null &&
                                                            photoFile != null &&
                                                            deviceId != null) {
                                                          context
                                                              .read<
                                                                  ViewMissionCubit>()
                                                              .checkOutMission(
                                                                MissionCheck(
                                                                  missionId:
                                                                      mission
                                                                          .id,
                                                                  latitude: position
                                                                      .latitude,
                                                                  longitude:
                                                                      position
                                                                          .longitude,
                                                                  photo:
                                                                      photoFile,
                                                                  udid:
                                                                      deviceId,
                                                                ),
                                                              );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                } else if (state is MissionError) {
                  return Center(child: Text(state.message));
                }

                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
