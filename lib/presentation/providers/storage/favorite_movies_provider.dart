import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:cinemacuenca/domain/repositories/local_storage_repository.dart';
import 'package:cinemacuenca/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>(
  (ref) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);
    return StorageMoviesNotifier(
        localStorageRepository: localStorageRepository);
  },
);

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<void> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    final tempMovieMap = <int, Movie>{};
    for (final movie in movies) {
      tempMovieMap[movie.id] = movie;
    }

    state = {...state, ...tempMovieMap};
  }
}
