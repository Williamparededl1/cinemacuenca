import 'package:animate_do/animate_do.dart';
import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNetPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNetPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subtitle != null)
            _Title(
              title: title,
              subtitle: subtitle,
            ),
          Expanded(
              child: ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _Slide(movie: movies[index]);
            },
          ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final titleStyleT = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Esto es la Imagen de la cartelera
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }

                    return FadeInUp(child: child);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //* Title

            SizedBox(
              width: 150,
              child: Center(
                child: Text(
                  movie.title,
                  maxLines: 2,
                  style: titleStyleT.titleSmall,
                ),
              ),
            ),

            //* Rating

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
                  style: titleStyleT.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text('${movie.popularity}', style: titleStyleT.bodySmall)
              ],
            )
          ],
        ));
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyleTs = Theme.of(context).textTheme.titleSmall;
    final titleStyleTm = Theme.of(context).textTheme.titleMedium;
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyleTm,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(
                  subtitle!,
                  style: titleStyleTs,
                )),
        ],
      ),
    );
  }
}
