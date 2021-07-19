import 'package:rx_state/rx_state.dart';

import '../../models/beer.dart';
import '../../service_locator/service_locator_mixin.dart';
import '../repositories/beer_repository.dart';

part 'punk_beers_actions.dart';
part 'punk_beers_state.dart';

class PunkBeersModule extends Module<PunkBeersState> with ServiceLocatorMixin {
  PunkBeersModule() : super(PunkBeersState.initial());

  late final BeersRepository beersRepository =
      serviceLocator<BeersRepository>();

  @override
  List<Type> get authorizedActions => [
        FetchBeersAction,
        FetchBeersSuccessAction,
        FetchBeersErrorAction,
      ];

  @override
  Future<PunkBeersState> reducer(PunkBeersState state, Action action) async {
    if (action is FetchBeersAction) {
      return PunkBeersState.isLoading();
    }

    if (action is FetchBeersSuccessAction) {
      return PunkBeersState.isLoaded(action.beers);
    }

    if (action is FetchBeersErrorAction) {
      return PunkBeersState.error(action.message);
    }

    return state;
  }

  @override
  Map<Type, EffectCallback> get effects => {
        FetchBeersAction: FetchBeersEffect(beersRepository),
      };
}

class FetchBeersEffect extends Effect {
  FetchBeersEffect(this.beersRepository);

  final BeersRepository beersRepository;

  @override
  Stream<Action> call(Action action) async* {
    try {
      final beers = await beersRepository.getBeers(itemsPerPage: 80);

      yield FetchBeersSuccessAction(beers: beers);
    } catch (e) {
      yield FetchBeersErrorAction(message: e.toString());
    }
  }
}
