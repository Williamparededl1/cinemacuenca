import 'package:cinemacuenca/domain/entities/actor.dart';
import 'package:cinemacuenca/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: (cast.profilePath != '')
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://static3.bigstockphoto.com/9/1/3/large1500/31903202.jpg',
      character: cast.character);
}
