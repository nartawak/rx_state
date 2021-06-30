import 'package:flutter/material.dart';
import 'package:flutter_punk_api/global_variables.dart';

import 'app.dart';

Future<void> main() async {
  await kRxState.init();
  runApp(PunkApiApp());
}
