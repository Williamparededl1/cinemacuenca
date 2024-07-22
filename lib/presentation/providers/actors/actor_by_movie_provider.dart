import 'package:cinemacuenca/domain/entities/actor.dart';
import 'package:cinemacuenca/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorByMovieNotifier(getActor: getActors);
});

typedef GetActors = Future<List<Actor>> Function(String movieID);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActors getActor;
  ActorByMovieNotifier({required this.getActor}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final List<Actor> actors = await getActor(movieId);

    state = {...state, movieId: actors};
  }
}
