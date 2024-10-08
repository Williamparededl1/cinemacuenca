import 'package:cinemacuenca/domain/entities/movie.dart';
import 'package:cinemacuenca/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemacuenca/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb movieDBToMovieDB) => Movie(
      adult: movieDBToMovieDB.adult,
      backdropPath: (movieDBToMovieDB.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDBToMovieDB.backdropPath}'
          : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      genreIds: movieDBToMovieDB.genreIds
          .map(
            (e) => e.toString(),
          )
          .toList(),
      id: movieDBToMovieDB.id,
      originalLanguage: movieDBToMovieDB.originalLanguage,
      originalTitle: movieDBToMovieDB.originalTitle,
      overview: movieDBToMovieDB.overview,
      popularity: movieDBToMovieDB.popularity,
      posterPath: (movieDBToMovieDB.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDBToMovieDB.posterPath}'
          : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      releaseDate: movieDBToMovieDB.releaseDate != null
          ? movieDBToMovieDB.releaseDate!
          : DateTime.now(),
      title: movieDBToMovieDB.title,
      video: movieDBToMovieDB.video,
      voteAverage: movieDBToMovieDB.voteAverage,
      voteCount: movieDBToMovieDB.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movieDBToMovieDB) => Movie(
      adult: movieDBToMovieDB.adult,
      backdropPath: (movieDBToMovieDB.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDBToMovieDB.backdropPath}'
          : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      genreIds: movieDBToMovieDB.genres
          .map(
            (e) => e.name,
          )
          .toList(),
      id: movieDBToMovieDB.id,
      originalLanguage: movieDBToMovieDB.originalLanguage,
      originalTitle: movieDBToMovieDB.originalTitle,
      overview: movieDBToMovieDB.overview,
      popularity: movieDBToMovieDB.popularity,
      posterPath: (movieDBToMovieDB.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDBToMovieDB.posterPath}'
          : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      releaseDate: movieDBToMovieDB.releaseDate,
      title: movieDBToMovieDB.title,
      video: movieDBToMovieDB.video,
      voteAverage: movieDBToMovieDB.voteAverage,
      voteCount: movieDBToMovieDB.voteCount);
}
