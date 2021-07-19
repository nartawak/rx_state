import '../rx_state.dart';
import './action.dart';

/// Type of the callable function that is defined by the call function in [Effect]
typedef EffectCallback = Stream<Action> Function(Action action);

/// [Effect] is used to manage side effect with [RxState]
/// [Effect] is callable class to be easier to inject dependencies.
///
/// To inject dependencies, you can use either constructor or dependency injection
///
/// ```dart
/// class CustomEffect extends Effect {
///
///   final CustomService service;
///
///   CustomEffect(this.service);
///
///   @override
///   Stream<Action> call(Action action) async* {
///     try {
///       final data = await service.fetchData();
///       yield FetchDataSuccessAction(data);
///     } catch (e) {
///       yield FetchDataErrorAction();
///     }
///   }
/// }
/// ```
abstract class Effect {
  /// Callable function
  Stream<Action> call(Action action);
}
