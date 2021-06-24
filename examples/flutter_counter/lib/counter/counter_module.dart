import 'package:rx_state/rx_state.dart';

part 'counter_actions.dart';

class CounterModule extends Module<int> {
  CounterModule() : super(0);

  @override
  List<Type> get authorizedActions => const [IncrementAction];

  @override
  Future<int> reducer(int state, Action action) async {
    if (action is IncrementAction) {
      return state + 1;
    }

    return state;
  }
}
