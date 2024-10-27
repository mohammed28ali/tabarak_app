import 'package:tabark_innov8/src/features/add_mission/data/model/model.dart';
import 'package:tabark_innov8/src/features/add_mission/data/repository/repository.dart';

class GetMissionTypes {
  final MissionRepository repository;

  GetMissionTypes(this.repository);

  Future<List<MissionType>> call() {
    return repository.getMissionTypes();
  }
}

class AddMission {
  final MissionRepository repository;

  AddMission(this.repository);

  Future<void> call(Mission mission) {
    return repository.addMission(mission);
  }
}
