import 'package:cinemacuenca/domain/entities/entities.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsByMovie(String movieID);
}
