import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'action.dart';
import 'module.dart';

/// [RxState]
class RxState {
  /// Create a [RxState]
  RxState({
    required Set<Module> modules,
  }) : _modules = modules;

  /// List of functional [Module]
  final Set<Module> _modules;

  final _actions$ = BehaviorSubject<Action>();
  late StreamSubscription<Action> _actionSubscription;

  /// Initialize [RxState]
  /// Init must be called before use of [RxState], it subscribe to
  /// [Action] stream to call doOnAction of each module
  Future<void> init() async {
    _actionSubscription = _actions$.stream.doOnData((action) async {
      await Future.wait(_modules.map((e) => e.mapActionToState(action)));
    }).doOnData((action) async {
      final actionType = action.runtimeType;
      for (final module in _modules) {
        if (module.effects.containsKey(actionType)) {
          await _actions$.addStream(module.effects[actionType]!.call(action));
        }
      }
    }).listen((_) {});

    dispatch(RxStateInitializedAction());
  }

  /// Dispatch an [Action]
  ///
  /// It will add an new [Action] in the [Stream] _actions$.
  void dispatch(Action action) {
    _actions$.add(action);
  }

  /// Add module in the list of modules managed by [RxState]
  /// Useful if you need to add a deferred module
  void addModule(Module module) {
    _modules.add(module);
  }

  /// Remove a module from the list of modules managed by [RxState]
  void removeModule(Module module) {
    module.dispose();
    _modules.remove(module);
  }

  /// Select a module by [Type]
  /// Return the first module with the given type
  Module selectModule<T>() {
    return _modules.firstWhere((module) => module is T);
  }

  /// Select the state stream of a [Module]
  ///
  /// T: module type
  /// K: state type
  ///
  /// ```dart
  /// final Stream<int> counter$ = rxState.selectState<CounterModule, int>();
  /// ```
  Stream<K> selectState<T, K>() {
    // TODO: manage error if module is not found
    return selectModule<T>().state as Stream<K>;
  }

  /// Dispose all elements that could create a memory leak
  Future<void> dispose() async {
    await _actionSubscription.cancel();
    await _actions$.close();

    for (final module in _modules) {
      module.dispose();
    }
  }
}
