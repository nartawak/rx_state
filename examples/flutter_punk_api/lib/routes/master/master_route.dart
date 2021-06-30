import 'package:flutter/material.dart';
import 'package:flutter_punk_api/global_variables.dart';
import 'package:flutter_punk_api/punk_beers/rx_state/punk_beers_module.dart';

import './widgets/punkapi_card.dart';
import '../detail/detail_route.dart';

class MasterRoute extends StatefulWidget {
  const MasterRoute();

  static const routeName = '/';

  @override
  _MasterRouteState createState() => _MasterRouteState();
}

class _MasterRouteState extends State<MasterRoute> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = Image.asset(
      'assets/images/punkapi.png',
      height: 40,
      width: 30,
      fit: BoxFit.fitHeight,
    );

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            const Text(
              'Punk API',
              style: TextStyle(
                fontFamily: 'Nerko_One',
                fontSize: 40,
              ),
            ),
            image,
          ],
        ),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: kRxState.selectState<PunkBeersModule, PunkBeersState>(),
        builder: (_, snapshot) {
          final state = snapshot.requireData! as PunkBeersState;

          if (state.errorMessage != null) {
            return Center(
              child: Text(state.errorMessage!),
            );
          }

          if (state.isLoading || (!state.isLoaded && !state.isLoading)) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: state.beers.length,
            itemBuilder: (_, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: PunkApiCard(
                  beer: state.beers[index],
                  onBeerSelected: (selectedBeer) {
                    Navigator.pushNamed(
                      context,
                      DetailRoute.routeName,
                      arguments: selectedBeer,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    kRxState.dispatch(FetchBeersAction());
    super.initState();
  }
}
