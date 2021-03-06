import 'package:flutter/material.dart';

import '../../../models/beer.dart';

typedef SelectedBeer = void Function(Beer beer);

class PunkApiCard extends StatelessWidget {
  const PunkApiCard({
    Key? key,
    required this.beer,
    this.onBeerSelected,
  }) : super(key: key);

  static const gestureDetectorKey = Key('gestureDetectorKey');

  final Beer beer;
  final SelectedBeer? onBeerSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      key: gestureDetectorKey,
      onTap: () {
        onBeerSelected?.call(beer);
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.4),
              offset: const Offset(0, 1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Hero(
                tag: beer.id,
                child: Image.network(
                  beer.imageURL,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beer.name,
                      style: theme.textTheme.headline6,
                    ),
                    if (beer.tagline != null)
                      Text(
                        beer.tagline!,
                        style: theme.textTheme.subtitle1,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
