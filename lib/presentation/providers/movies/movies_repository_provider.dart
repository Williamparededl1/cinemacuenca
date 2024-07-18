import 'package:cinemacuenca/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemacuenca/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositriio es inmutablle
final moviesRepositoryProvider = Provider(
  (ref) {
    return MovieRepositoryImpl(MoviedbDatasource());
  },
);
