import 'package:flutter/material.dart';

import '../../models/beer.dart';

class DetailRoute extends StatelessWidget {
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final beer = ModalRoute.of(context)!.settings.arguments! as Beer;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(beer.name),
      ),
      body: Container(
        color: theme.cardColor,
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Hero(
                    tag: beer.id,
                    child: Image.network(beer.imageURL),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (beer.tagline != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      beer.tagline!,
                      style: theme.textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (beer.description != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      beer.description!,
                      style: theme.textTheme.bodyText1,
                      textAlign: TextAlign.justify,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
