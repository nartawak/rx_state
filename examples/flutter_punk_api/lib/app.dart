import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'punkapi_theme.dart';
import 'repositories/beer_repository.dart';
import 'routes/detail/detail_route.dart';
import 'routes/master/master_route.dart';

const kApiBaseUrl = 'https://api.punkapi.com/v2';

class PunkApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: MasterRoute.routeName,
      routes: <String, WidgetBuilder>{
        MasterRoute.routeName: (_) => MasterRoute(
              beersRepository: BeersRepository(
                client: Dio(BaseOptions(baseUrl: kApiBaseUrl)),
              ),
            ),
        DetailRoute.routeName: (_) => DetailRoute(),
      },
    );
  }
}
