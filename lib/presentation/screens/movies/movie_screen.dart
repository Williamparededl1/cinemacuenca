import 'package:animate_do/animate_do.dart';
import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:cinemacuenca/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) => _MovieDescription(movie: movie),
          ))
        ],
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  final Movie movie;
  const _MovieDescription({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                    ),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        //TODO: Actores
        _ActorByMovie(
          movieId: movie.id.toString(),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}

class _ActorByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorByMovie = ref.watch(actorsByMovieProvider);

    if (actorByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }
    final actors = actorByMovie[movieId]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor Photo

                FadeInDown(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //Actor Name
                const SizedBox(
                  height: 5,
                ),

                Text(
                  actor.name,
                  maxLines: 2,
                ),

                //Actor Character

                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family(
  (ref, int movieId) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);

    return localStorageRepository.isMovieFavorite(movieId);
  },
);

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .watch(localStorageRepositoryProvider)
                .toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },

          //
          icon: isFavoriteFuture.when(
              data: (data) => data
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 7),
        background: _ImageBackgroundSliver(
          urlImg: movie.posterPath,
        ),
      ),
    );
  }
}

class _ImageBackgroundSliver extends StatelessWidget {
  final String urlImg;
  const _ImageBackgroundSliver({required this.urlImg});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            urlImg,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) return const SizedBox();
              return FadeIn(child: child);
            },
          ),
        ),
        const _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.7, 1.0],
            colors: [Colors.transparent, Colors.black87]),
        const _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.20],
            colors: [Colors.black87, Colors.transparent]),
      ],
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final Alignment begin;
  final Alignment end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {required this.begin,
      required this.end,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
