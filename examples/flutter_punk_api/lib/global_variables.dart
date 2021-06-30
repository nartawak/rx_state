import 'package:dio/dio.dart';
import 'package:rx_state/rx_state.dart';

import 'punk_beers/repositories/beer_repository.dart';
import 'punk_beers/rx_state/punk_beers_module.dart';

const kApiBaseUrl = 'https://api.punkapi.com/v2';

final kRxState = RxState(modules: {
  PunkBeersModule(
      beersRepository: BeersRepository(
    client: Dio(BaseOptions(baseUrl: kApiBaseUrl)),
  )),
});
