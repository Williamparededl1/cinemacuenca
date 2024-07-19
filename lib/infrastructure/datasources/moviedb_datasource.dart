import 'package:cinemacuenca/config/constants/enviroment.dart';
import 'package:cinemacuenca/domain/datasources/movies_datasource.dart';
import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:cinemacuenca/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemacuenca/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> moviesNowPlaying = movieDBResponse.results
        .where((toMovieDb) => toMovieDb.posterPath != 'no-poster')
        .map(
          (toMovieDb) => MovieMapper.movieDBToEntity(toMovieDb),
        )
        .toList();

    return moviesNowPlaying;
  }
}
