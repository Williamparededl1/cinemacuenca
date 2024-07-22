import 'package:cinemacuenca/config/constants/enviroment.dart';
import 'package:cinemacuenca/domain/datasources/actors_datasource.dart';
import 'package:cinemacuenca/domain/entities/actor.dart';
import 'package:cinemacuenca/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemacuenca/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }));

  List<Actor> _jsonToActors(Map<String, dynamic> json) {
    final actorsMDBResponse = CreditsResponse.fromJson(json);

    final List<Actor> actorsByMovie = actorsMDBResponse.cast
        .map(
          (toMovieDb) => ActorMapper.castToEntity(toMovieDb),
        )
        .toList();

    return actorsByMovie;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieID) async {
    final response = await dio.get('/movie/$movieID/credits');

    return _jsonToActors(response.data);
  }
}
