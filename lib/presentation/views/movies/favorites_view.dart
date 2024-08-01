import 'package:animate_do/animate_do.dart';
import 'package:cinemacuenca/presentation/providers/providers.dart';
import 'package:cinemacuenca/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView>
    with AutomaticKeepAliveClientMixin {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final mapMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (mapMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 100,
              color: colors.primary,
            ),
            Text(
              'Ohh no!!!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const Text(
              'No tienes peliculas favoritas',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            FadeIn(
              child: FilledButton.tonal(
                  onPressed: () => context.go('/home/0'),
                  child: const Text('Escoge tus Favoritas')),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: mapMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
