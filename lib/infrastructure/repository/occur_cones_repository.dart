import 'package:umimamoru/domain/cone_state.dart';
import 'package:umimamoru/domain/occur_cones.dart';
import 'package:umimamoru/domain/repository/occur_state_repository.dart';
import 'package:umimamoru/infrastructure/repository/cone_state_repository.dart';

class OccurConesRepository implements OccurStateRepository {

  @override
  Future<OccurCones> occurState(String beach) async{
    List<String> occurCone = [];
    ConeStateRepository repository = ConeStateRepository();
    List<ConeState> coneState = await repository.coneState(beach);
    coneState.forEach((entity) {
      if (entity.level == "Fast") occurCone.add(entity.cone);
    });
    return OccurCones(occurCone);
  }
}