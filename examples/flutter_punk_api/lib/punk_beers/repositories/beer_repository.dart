import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../exceptions/custom_exceptions.dart';
import '../../models/beer.dart';

const kBeerResource = 'beers';

@immutable
class BeersRepository {
  const BeersRepository({required this.client});

  final Dio client;

  Future<List<Beer>> getBeers({
    int pageNumber = 1,
    int itemsPerPage = 10,
  }) async {
    try {
      final response = await client.get<List<dynamic>>(
        '/$kBeerResource',
        queryParameters: <String, int>{
          'page': pageNumber,
          'per_page': itemsPerPage,
        },
      );

      return response.data!
          .map<Beer>(
            (dynamic json) => Beer.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      return Future.error(
        FetchDataException(
          'error occurred when fetch beers from punk API: {$e}',
        ),
      );
    }

    //return parsed.map<Beer>((json) => Beer.fromJson(json)).toList();
  }
}
