import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemacuenca/config/helpers/human_formats.dart';
import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  void clearStraems() {
    debounceMovies.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        final movies = await searchMovies(query);
        debounceMovies.add(movies);
        initialMovies = movies;
        isLoadingStream.add(false);
      },
    );
  }

  Widget builResultsAndSuggestion() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(
                  movie: movies[index],
                  onMovieSelected: (context, movie) {
                    clearStraems();
                    close(context, movie);
                  },
                ));
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 10),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '', icon: const Icon(Icons.refresh)),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      ),

      // ,
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStraems();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    return builResultsAndSuggestion();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return builResultsAndSuggestion();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //image
            SizedBox(
              width: size.width * 0.35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            //Descripcion

            SizedBox(
              width: size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium,
                  ),
                  Text(
                    movie.overview,
                    style: textStyle.bodySmall,
                    maxLines: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${movie.voteAverage}',
                        style: textStyle.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade800),
                      ),
                      const Spacer(),
                      Text(HumanFormats.number(movie.popularity),
                          style: textStyle.bodySmall)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
