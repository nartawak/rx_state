import 'package:rx_state/src/action.dart';
import 'package:rx_state/src/effect.dart';
import 'package:rx_state/src/module.dart';
import 'package:test/test.dart';

class MockIncrementAction extends Action {
  @override
  String get name => 'Mock Increment action';
}

class MockNotAuthorizedAction extends Action {
  @override
  String get name => 'Mock not authorized action';
}

class CounterModule extends Module<int> {
  CounterModule() : super(0);

  @override
  List<Type> get authorizedActions => [MockIncrementAction];

  @override
  Map<Type, EffectCallback> get effects => {};

  @override
  Future<int> reducer(int state, Action action) async {
    if (action is MockIncrementAction) {
      return state + 1;
    }

    return state;
  }
}

void main() {
  group('Module', () {
    late CounterModule counterModule;

    setUp(() {
      counterModule = CounterModule();
    });

    group('state', () {
      test('should emit the initialState (0)', () async {
        await expectLater(counterModule.state, emits(0));
      });

      test('should close the state behavior subject when dispose is called',
          () async {
        await counterModule.dispose();

        expect(counterModule.state$.isClosed, equals(true));
      });
    });

    group('mapActionToState', () {
      test('should not emit an new state when action is not authorized',
          () async {
        await counterModule.mapActionToState(MockNotAuthorizedAction());
        await expectLater(counterModule.state, emits(0));
      });

      test(
          'should emit initialState and the new value when action is authorized',
          () async {
        await expectLater(counterModule.state, emits(0));
        await counterModule.mapActionToState(MockIncrementAction());
        await expectLater(counterModule.state, emits(1));
      });
    });
  });
}
