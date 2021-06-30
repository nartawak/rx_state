import 'package:flutter_punk_api/punk_beers/repositories/beer_repository.dart';
import 'package:rx_state/rx_state.dart';

import '../../models/beer.dart';

part 'punk_beers_actions.dart';
part 'punk_beers_state.dart';

class PunkBeersModule extends Module<PunkBeersState> {
  PunkBeersModule({required this.beersRepository})
      : super(PunkBeersState.initial());

  final BeersRepository beersRepository;

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

  Stream<Action> _transformFetchBeersAction(Action _) async* {
    try {
      final beers = await beersRepository.getBeers(itemsPerPage: 80);

      yield FetchBeersSuccessAction(beers: beers);
    } catch (e) {
      yield FetchBeersErrorAction(message: e.toString());
    }
  }

  @override
  Map<Type, Stream<Action> Function(Action action)> get effects => {
        FetchBeersAction: _transformFetchBeersAction,
      };
}
