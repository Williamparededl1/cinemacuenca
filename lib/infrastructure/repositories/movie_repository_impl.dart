import 'package:cinemacuenca/domain/datasources/movies_datasource.dart';
import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:cinemacuenca/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
