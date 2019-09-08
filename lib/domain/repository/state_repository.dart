import 'package:umimamoru/domain/cone_state.dart';

abstract class StateRepository {
  Future<List<ConeState>> coneState(String beach);
}