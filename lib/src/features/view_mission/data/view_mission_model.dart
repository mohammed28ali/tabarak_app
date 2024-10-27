import 'dart:io';

class MissionsListModel {
  final int id;
  final String date;
  final String missionType;
  final String reason;

  MissionsListModel({
    required this.id,
    required this.date,
    required this.missionType,
    required this.reason,
  });

  factory MissionsListModel.fromJson(Map<String, dynamic> json) {
    return MissionsListModel(
      id: json['Id'],
      date: json['Date'],
      missionType: json['MissionType'],
      reason: json['Reason'],
    );
  }
}

class MissionCheckModel {
  final int missionId;
  final double latitude;
  final double longitude;
  final File photo;
  final String udid;

  MissionCheckModel({
    required this.missionId,
    required this.latitude,
    required this.longitude,
    required this.photo,
    required this.udid,
  });

  Map<String, dynamic> toJson() => {
        'MissionId': missionId,
        'Latitude': latitude,
        'Longitude': longitude,
        'Photo': photo,
        'UDID': udid,
      };
}
