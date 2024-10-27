import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tabark_innov8/src/core/extenstions/empty_box_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/navigator_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/extenstions/toast_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_colors.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';
import 'package:tabark_innov8/src/core/widgets/custom_common_button.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text.dart';
import 'package:tabark_innov8/src/core/widgets/custom_text_field.dart';
import 'package:tabark_innov8/src/core/widgets/cutstom_dropdown_button.dart';
import 'package:tabark_innov8/src/core/widgets/success_dialog.dart';
import 'package:tabark_innov8/src/features/add_mission/data/model/model.dart';

import '../../../../config/dependency_injection/dependency_injection.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../home/presentataion/widgets/location_container.dart';
import '../bussiness_logic/cubit.dart';
import '../bussiness_logic/state.dart';

class AddMissionScreen extends StatefulWidget {
  const AddMissionScreen({super.key});

  @override
  _AddMissionScreenState createState() => _AddMissionScreenState();
}

class _AddMissionScreenState extends State<AddMissionScreen> {
  String? selectedMissionTypeId;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String reason = '';

  List<String> generateTimeOptions() {
    List<String> timeOptions = [];

    for (int hour = 1; hour <= 12; hour++) {
      timeOptions.add('$hour:00 صباحا');
      timeOptions.add('$hour:00 مساءا');
    }

    timeOptions.sort((a, b) {
      bool isAMa = a.contains('صباحا');
      bool isAMb = b.contains('صباحا');
      int hourA = int.parse(a.split(':')[0]);
      int hourB = int.parse(b.split(':')[0]);

      if (isAMa && !isAMb) return -1;
      if (!isAMa && isAMb) return 1;
      return hourA.compareTo(hourB);
    });

    return timeOptions;
  }

  String convertTo24HourFormat(String time) {
    String cleanedTime =
        time.replaceAll('صباحا', 'AM').replaceAll('مساءا', 'PM');
    DateTime tempDate = DateFormat('h:mm a').parse(cleanedTime);
    return DateFormat('HH:mm').format(tempDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          text: AppStrings.addMission,
          color: Colors.black,
          fontSize: AppSize.s20,
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      bottomNavigationBar: const LocationContainer(),
      body: SingleChildScrollView(
        child: BlocConsumer<MissionCubit, MissionState>(
          listener: (context, state) {
            if (state is MissionCreated) {
              showDialog(
                context: context,
                builder: (context) => const SuccessDialogPopup(
                  text: AppStrings.sucessAddMission,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (context.height * 0.025).emptyBoxHeight,
                      const CustomText(
                        text: AppStrings.missionType,
                        color: Colors.black,
                      ),
                      (context.height * 0.025).emptyBoxHeight,
                      BlocBuilder<MissionCubit, MissionState>(
                        builder: (context, state) {
                          if (state is MissionLoaded) {
                            return CustomDropdownButton(
                              items: state.missionTypes.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type.id.toString(),
                                  child: Text(type.name),
                                );
                              }).toList(),
                              hintText: AppStrings.chooseMissionType,
                              onChanged: (value) {
                                setState(() {
                                  selectedMissionTypeId = value;
                                });
                              },
                            );
                          } else if (state is MissionLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const CustomText(
                                text: AppStrings.failedLoadMissionTypes);
                          }
                        },
                      ),
                      (context.height * 0.025).emptyBoxHeight,
                      const CustomText(
                        text: AppStrings.missionDate,
                        color: Colors.black,
                      ),
                      (context.height * 0.025).emptyBoxHeight,
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.textFormFiledBorderColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    readonly: true,
                                    hintText: AppStrings.startDate,
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                      color: AppColors.greyColor,
                                    ),
                                    onTap: () async {
                                      final pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            startDate ?? DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      setState(() {
                                        startDate = pickedDate;
                                      });
                                    },
                                    controller: TextEditingController(
                                      text: startDate != null
                                          ? DateFormat.yMd().format(startDate!)
                                          : '',
                                    ),
                                  ),
                                ),
                                (context.width * 0.015).emptyBoxWidth,
                                Expanded(
                                  child: CustomDropdownButton(
                                    items: generateTimeOptions().map((time) {
                                      return DropdownMenuItem<String>(
                                        value: time,
                                        child: Text(time),
                                      );
                                    }).toList(),
                                    hintText: AppStrings.selectTime,
                                    onChanged: (value) {
                                      setState(() {
                                        startTime = value;
                                      });
                                    },
                                    // value: startTime,
                                  ),
                                ),
                              ],
                            ),
                            (context.height * 0.025).emptyBoxHeight,
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    readonly: true,
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                      color: AppColors.greyColor,
                                    ),
                                    hintText: AppStrings.endDate,
                                    onTap: () async {
                                      final pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: endDate ?? DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      setState(() {
                                        endDate = pickedDate;
                                      });
                                    },
                                    controller: TextEditingController(
                                      text: endDate != null
                                          ? DateFormat.yMd().format(endDate!)
                                          : '',
                                    ),
                                  ),
                                ),
                                (context.width * 0.015).emptyBoxWidth,
                                Expanded(
                                  child: CustomDropdownButton(
                                    items: generateTimeOptions().map((time) {
                                      return DropdownMenuItem<String>(
                                        value: time,
                                        child: Text(time),
                                      );
                                    }).toList(),
                                    hintText: AppStrings.selectTime,
                                    onChanged: (value) {
                                      setState(() {
                                        endTime = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      (context.height * 0.025).emptyBoxHeight,
                      const CustomText(
                        text: AppStrings.statement,
                        color: Colors.black,
                      ),
                      (context.height * 0.025).emptyBoxHeight,
                      CustomTextField(
                        hintText: AppStrings.writeReason,
                        onChanged: (value) {
                          reason = value;
                        },
                      ),
                      (context.height * 0.025).emptyBoxHeight,
                      CommonButton(
                        text: AppStrings.add,
                        onPressed: () {
                          if (selectedMissionTypeId != null &&
                              startDate != null &&
                              endDate != null &&
                              startTime != null &&
                              endTime != null &&
                              reason.isNotEmpty) {
                            String formattedStartDate =
                                DateFormat('yyyy-MM-dd').format(startDate!);
                            String formattedEndDate =
                                DateFormat('yyyy-MM-dd').format(endDate!);

                            String formattedStartTime =
                                convertTo24HourFormat(startTime!);
                            String formattedEndTime =
                                convertTo24HourFormat(endTime!);
                            final mission = Mission(
                              missionTypeId: int.parse(selectedMissionTypeId!),
                              startDate: formattedStartDate,
                              endDate: formattedEndDate,
                              startTime: formattedStartTime,
                              endTime: formattedEndTime,
                              reason: reason,
                            );
                            context.read<MissionCubit>().createMission(mission);
                          } else {
                            context.errorSnackBar(AppStrings.completeData, 2);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
