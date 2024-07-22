import 'package:cinemacuenca/domain/datasources/actors_datasource.dart';
import 'package:cinemacuenca/domain/entities/actor.dart';
import 'package:cinemacuenca/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieID) {
    return datasource.getActorsByMovie(movieID);
  }
}
