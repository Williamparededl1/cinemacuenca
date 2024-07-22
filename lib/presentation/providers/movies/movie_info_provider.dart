import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:cinemacuenca/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapProvider, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(moviesRepositoryProvider).getMovieById;
  return MovieMapProvider(getMovie: getMovie);
});

typedef GetMovieCallback = Future<Movie> Function(String movieID);

class MovieMapProvider extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapProvider({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
