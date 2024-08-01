import 'package:cinemacuenca/domain/entities/entities.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieID);
}
