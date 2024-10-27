// domain/entities/mission.dart
import 'dart:io';

import 'package:tabark_innov8/src/features/view_mission/data/view_mission_model.dart';

class MissionList {
  final int id;
  final String date;
  final String missionType;
  final String reason;

  MissionList({
    required this.id,
    required this.date,
    required this.missionType,
    required this.reason,
  });
}

class MissionCheck {
  final int missionId;
  final double latitude;
  final double longitude;
  final File photo;
  final String udid;

  MissionCheck({
    required this.missionId,
    required this.latitude,
    required this.longitude,
    required this.photo,
    required this.udid,
  });

  MissionCheckModel toModel() {
    return MissionCheckModel(
      missionId: missionId,
      latitude: latitude,
      longitude: longitude,
      photo: photo,
      udid: udid,
    );
  }
}
