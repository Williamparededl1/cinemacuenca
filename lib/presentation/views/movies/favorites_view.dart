import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:cinemacuenca/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final mapMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
        body: ListView.builder(
      itemCount: mapMovies.length,
      itemBuilder: (context, index) {
        final movie = mapMovies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    ));
  }
}
