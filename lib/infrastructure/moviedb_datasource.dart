import 'package:cinemacuenca/config/constants/enviroment.dart';
import 'package:cinemacuenca/domain/datasources/movies_datasource.dart';
import 'package:cinemacuenca/domain/entities/movie.dart';
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
    final response = await dio.get('/movie/now_playing');

    final List<Movie> moviesNowPlaying = [];

    return moviesNowPlaying;
  }
}
