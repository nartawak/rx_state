import 'rx_state.dart';

/// [Action]
abstract class Action {
  /// Define action name that will be used to identify an action
  String get name;
}

/// This action is dispatching when [RxState] is initialized
class RxStateInitializedAction extends Action {
  @override
  String get name => 'RxState: initialized';
}
