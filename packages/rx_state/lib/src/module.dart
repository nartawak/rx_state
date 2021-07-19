import 'package:rxdart/subjects.dart';
import 'package:meta/meta.dart';

import 'action.dart';
import 'effect.dart';

/// [Module] is made to encapsulate a specific functional domain
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
  Module(T initialState) : state$ = BehaviorSubject<T>.seeded(initialState);

  /// states subject
  @visibleForTesting
  final BehaviorSubject<T> state$;

  /// [Stream] of states
  Stream<T> get state => state$.asBroadcastStream();

  /// List of [Type] that extends [Action]
  /// [reducer] function will call only for authorized actions
  List<Type> get authorizedActions;

  /// Define [Map] of side effects for this module
  ///
  /// [Type] Class that extend [Action]
  /// [EffectCallback] callback executed when an [Action] with [Type] emits
  /// in the [BehaviorSubject] actions
  ///
  /// ```dart
  ///
  /// class CustomModule extends Module<State> {
  ///  @override
  ///   Map<Type, EffectCallback> get effects => {
  ///         MyAction: MyEffect(),
  ///       };
  /// }
  ///
  /// ```
  Map<Type, EffectCallback> get effects;

  /// If [Action] type is contained in the [authorizedActions],
  /// [reducer] function is called and the new state is adding to the state stream
  Future<void> mapActionToState(Action action) async {
    if (authorizedActions.contains(action.runtimeType) && state$.hasValue) {
      state$.add(await reducer(state$.value, action));
    }
  }

  /// Create a new state from previous state and action
  Future<T> reducer(T state, Action action);

  /// Dispose all elements that could create a memory leak
  Future<void> dispose() async {
    await state$.close();
  }
}
