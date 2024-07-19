import 'package:card_swiper/card_swiper.dart';
import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlidesshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlidesshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
