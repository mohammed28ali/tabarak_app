import 'package:tabark_innov8/src/features/view_mission/data/view_mission_model.dart';

abstract class ViewMissionRepository {
  Future<List<MissionsListModel>> getMissions(int pageNumber);
  Future<void> missionCheck(String endpoint, MissionCheckModel missionCheck);
}
