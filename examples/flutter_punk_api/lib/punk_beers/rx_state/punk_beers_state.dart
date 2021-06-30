part of 'punk_beers_module.dart';

class PunkBeersState {
  const PunkBeersState._(
      {required this.isLoading,
      required this.isLoaded,
      required this.beers,
      required this.errorMessage});

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

  PunkBeersState.isLoaded(List<Beer> fetchedBeers)
      : beers = fetchedBeers,
        isLoaded = true,
        isLoading = false,
        errorMessage = null;

  PunkBeersState.error(String error)
      : beers = const [],
        isLoaded = true,
        isLoading = false,
        errorMessage = error;

  final bool isLoading;
  final bool isLoaded;
  final List<Beer> beers;
  final String? errorMessage;
}
