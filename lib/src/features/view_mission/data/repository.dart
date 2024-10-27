import 'package:tabark_innov8/src/features/view_mission/data/data_source.dart';
import 'package:tabark_innov8/src/features/view_mission/data/view_mission_model.dart';
import 'package:tabark_innov8/src/features/view_mission/domain/repository.dart';

class MissionRepositoryImpl implements ViewMissionRepository {
  final MissionDataSource dataSource;

  MissionRepositoryImpl(this.dataSource);

  @override
  Future<List<MissionsListModel>> getMissions(int pageNumber) async {
    return await dataSource.getMissions(pageNumber);
  }

  @override
  Future<void> missionCheck(
      String endpoint, MissionCheckModel missionCheck) async {
    await dataSource.missionCheck(endpoint, missionCheck);
  }
}
