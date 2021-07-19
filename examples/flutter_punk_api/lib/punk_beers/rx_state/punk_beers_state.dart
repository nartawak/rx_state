part of 'punk_beers_module.dart';

class PunkBeersState {
  PunkBeersState.initial()
      : isLoaded = false,
        isLoading = false,
        errorMessage = null,
        beers = const [];

  PunkBeersState.isLoading()
      : isLoaded = false,
        isLoading = true,
        errorMessage = null,
        beers = const [];

  PunkBeersState.isLoaded(this.beers)
      : isLoaded = true,
        isLoading = false,
        errorMessage = null;

  PunkBeersState.error(this.errorMessage)
      : beers = const [],
        isLoaded = true,
        isLoading = false;

  final bool isLoading;
  final bool isLoaded;
  final List<Beer> beers;
  final String? errorMessage;
}
