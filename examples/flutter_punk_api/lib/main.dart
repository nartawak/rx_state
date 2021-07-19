import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rx_state/rx_state.dart';

import 'app.dart';
import 'punk_beers/repositories/beer_repository.dart';
import 'punk_beers/rx_state/punk_beers_module.dart';

Future<void> main() async {
  GetIt.instance.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'https://api.punkapi.com/v2'),
    ),
  );

  GetIt.instance.registerSingleton<BeersRepository>(
    BeersRepository(),
  );

  final rxState = RxState(
    modules: {
      PunkBeersModule(),
    },
  );
  await rxState.init();
  GetIt.instance.registerSingleton<RxState>(rxState);

  runApp(PunkApiApp());
}
