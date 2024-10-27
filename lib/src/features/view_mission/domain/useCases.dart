import 'package:tabark_innov8/src/features/view_mission/data/view_mission_model.dart';
import 'package:tabark_innov8/src/features/view_mission/domain/repository.dart';

class GetMissionsUseCase {
  final ViewMissionRepository repository;

  GetMissionsUseCase(this.repository);

  Future<List<MissionsListModel>> call(int pageNumber) async {
    return await repository.getMissions(pageNumber);
  }
}

class MissionCheckUseCase {
  final ViewMissionRepository repository;

  MissionCheckUseCase(this.repository);

  Future<void> execute(String endpoint, MissionCheckModel missionCheck) async {
    await repository.missionCheck(endpoint, missionCheck);
  }
}
