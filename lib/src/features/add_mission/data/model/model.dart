import 'dart:developer';

class Mission {
  final int missionTypeId;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String reason;

  Mission({
    required this.missionTypeId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'MissionTypeId': missionTypeId,
      'StartDate': startDate,
      'EndDate': endDate,
      'StartTime': startTime,
      'EndTime': endTime,
      'Reason': reason,
    };
  }
}

class MissionType {
  final String id;
  final String name;

  MissionType({required this.id, required this.name});

  factory MissionType.fromJson(Map<String, dynamic> json) {
    return MissionType(
      id: json['Id'].toString(),
      name: json['Name'] ?? '',
    );
  }

  @override
  String toString() {
    return 'MissionType{id: $id, name: $name}';
  }
}
