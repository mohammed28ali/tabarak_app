import 'package:tabark_innov8/src/features/view_mission/data/view_mission_model.dart';

abstract class ViewMissionState {}

class MissionInitial extends ViewMissionState {}

class MissionLoading extends ViewMissionState {}

class MissionLoaded extends ViewMissionState {
  final List<MissionsListModel> missions;
  final int currentPage;

  MissionLoaded(this.missions, this.currentPage);
}

class MissionCheckInSuccess extends ViewMissionState {}

class MissionCheckOutSuccess extends ViewMissionState {}

class MissionError extends ViewMissionState {
  final String message;

  MissionError(this.message);
}
