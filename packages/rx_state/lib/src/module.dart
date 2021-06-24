import 'package:rxdart/subjects.dart';

import 'action.dart';

/// [Module] is made to encapsulate specific functional domain
///
/// Only [authorizedActions] can be used to execute [reducer] function.
///
/// ```dart
/// class CounterModule extends Module<int> {
///   CounterModule() : super(0);
///
///   @override
///   List<Type> get authorizedActions => const [IncrementAction];
///
///   @override
///   Future<int> reducer(int state, Action action) async {
///     if (action is IncrementAction) {
///       return state + 1;
///     }
///
///     return state;
///   }
/// }
/// ```
abstract class Module<T> {
  /// Create a [Module]
  ///
  /// T: state type
  /// initialState: first value of the state in the [BehaviorSubject]
  Module(T initialState) : _state$ = BehaviorSubject.seeded(initialState);

  final BehaviorSubject<T> _state$;

  /// [Stream] of states
  Stream<T> get state => _state$.asBroadcastStream();

  /// List of [Type] that extends [Action]
  /// [reducer] function will call only for authorized actions
  List<Type> get authorizedActions;

  /// If [Action] type is contained in the [authorizedActions],
  /// [reducer] function is called and the new state is adding to the state stream
  Future<void> mapActionToState(Action action) async {
    if (authorizedActions.contains(action.runtimeType) && _state$.hasValue) {
      _state$.add(await reducer(_state$.value, action));
    }
  }

  /// Create a new state from previous state and action
  Future<T> reducer(T state, Action action);

  /// Dispose all elements that could create a memory leak
  void dispose() {
    _state$.close();
  }
}
