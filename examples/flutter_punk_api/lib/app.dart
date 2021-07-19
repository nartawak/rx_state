import 'package:flutter/material.dart';

import 'punkapi_theme.dart';
import 'routes/detail/detail_route.dart';
import 'routes/master/master_route.dart';

class PunkApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: MasterRoute.routeName,
      routes: <String, WidgetBuilder>{
        MasterRoute.routeName: (_) => const MasterRoute(),
        DetailRoute.routeName: (_) => DetailRoute(),
      },
    );
  }
}
