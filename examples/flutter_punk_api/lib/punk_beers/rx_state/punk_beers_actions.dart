part of 'punk_beers_module.dart';

class FetchBeersAction extends Action {
  @override
  String get name => 'Punk Beers: Fetch beers';
}

class FetchBeersSuccessAction extends Action {
  const FetchBeersSuccessAction({required this.beers}) : super();

  final List<Beer> beers;

  @override
  String get name => 'Punk Beers: Fetch beers success';
}

class FetchBeersErrorAction extends Action {
  const FetchBeersErrorAction({required this.message}) : super();

  final String message;

  @override
  String get name => 'Punk Beers: Fetch beers error';
}
