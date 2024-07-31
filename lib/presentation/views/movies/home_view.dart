import 'package:cinemacuenca/presentation/providers/providers.dart';
import 'package:cinemacuenca/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(initialLoadingProvider)) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        centerTitle: false,
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.zero,
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlidesshow(movies: slideShowMovies),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En Cines',
              subtitle: 'Viernes 19',
              loadNetPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: upComingMovies,
              title: 'Proximamente',
              subtitle: 'En este mes',
              loadNetPage: () =>
                  ref.read(upComingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              subtitle: 'Desde siempre',
              loadNetPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor Calificadas',
              subtitle: 'De todos los tiempos',
              loadNetPage: () =>
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        );
      }, childCount: 1)),
    ]);
  }
}
