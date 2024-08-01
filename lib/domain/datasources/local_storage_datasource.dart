import 'package:cinemacuenca/domain/entities/entities.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 12, offset = 0});
}
