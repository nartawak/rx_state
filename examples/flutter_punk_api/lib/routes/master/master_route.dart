import 'package:flutter/material.dart';

import './widgets/punkapi_card.dart';
import '../../models/beer.dart';
import '../../repositories/beer_repository.dart';
import '../detail/detail_route.dart';

class MasterRoute extends StatelessWidget {
  const MasterRoute({required this.beersRepository});

  static const routeName = '/';

  final BeersRepository beersRepository;

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
      body: FutureBuilder(
        future: beersRepository.getBeers(itemsPerPage: 80),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final beers = snapshot.data! as List<Beer>;

          return ListView.builder(
            itemCount: beers.length,
            itemBuilder: (_, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: PunkApiCard(
                  beer: beers[index],
                  onBeerSelected: (Beer selectedBeer) {
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
}
