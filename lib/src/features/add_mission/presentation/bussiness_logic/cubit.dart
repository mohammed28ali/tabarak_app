import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/features/add_mission/presentation/bussiness_logic/state.dart';

import '../../data/model/model.dart';
import '../../domain/usecase/usecase.dart';

class MissionCubit extends Cubit<MissionState> {
  final GetMissionTypes getMissionTypes;
  final AddMission addMission;

  MissionCubit(this.getMissionTypes, this.addMission) : super(MissionInitial());

  Future<void> fetchMissionTypes() async {
    emit(MissionLoading());
    try {
      final missionTypes = await getMissionTypes();
      emit(MissionLoaded(missionTypes));
    } catch (error) {
      emit(MissionError(error.toString()));
    }
  }

  Future<void> createMission(Mission mission) async {
    emit(MissionLoading());
    try {
      await addMission(mission);
      emit(MissionCreated());
      fetchMissionTypes();
    } catch (error) {
      emit(MissionError(error.toString()));
    }
  }
}
