import '../../data/model/model.dart';

abstract class MissionState {}

class MissionInitial extends MissionState {}

class MissionLoading extends MissionState {}

class MissionLoaded extends MissionState {
  final List<MissionType> missionTypes;

  MissionLoaded(this.missionTypes);
}

class MissionCreated extends MissionState {}

class MissionError extends MissionState {
  final String message;

  MissionError(this.message);
}
