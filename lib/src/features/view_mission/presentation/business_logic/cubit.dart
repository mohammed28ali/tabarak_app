import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';
import 'package:tabark_innov8/src/features/view_mission/domain/Entity.dart';
import 'package:tabark_innov8/src/features/view_mission/domain/useCases.dart';
import 'package:tabark_innov8/src/features/view_mission/presentation/business_logic/state.dart';

class ViewMissionCubit extends Cubit<ViewMissionState> {
  final GetMissionsUseCase getMissionsUseCase;
  final MissionCheckUseCase missionCheckUseCase;

  ViewMissionCubit(this.getMissionsUseCase, this.missionCheckUseCase)
      : super(MissionInitial());

  Future<void> fetchMissions(int pageNumber) async {
    emit(MissionLoading());
    try {
      final missions = await getMissionsUseCase.call(pageNumber);
      emit(MissionLoaded(missions, pageNumber));
    } catch (error) {
      emit(MissionError("Failed to load missions"));
    }
  }

  Future<void> checkInMission(MissionCheck missionCheck) async {
    emit(MissionLoading());

    try {
      await missionCheckUseCase.execute(
          EndPoints.missionCheckin, missionCheck.toModel());
      fetchMissions(1);
      emit(MissionCheckInSuccess());
    } catch (error) {
      emit(MissionError("Failed to check in"));
    }
  }

  Future<void> checkOutMission(MissionCheck missionCheck) async {
    emit(MissionLoading());

    try {
      await missionCheckUseCase.execute(
          EndPoints.missionCheckout, missionCheck.toModel());
      fetchMissions(1);

      emit(MissionCheckOutSuccess());
    } catch (error) {
      emit(MissionError("Failed to check out"));
    }
  }
}
