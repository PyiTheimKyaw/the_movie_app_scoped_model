import 'package:hive/hive.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/persistence/hive_constants.dart';

class ActorDao {
  static final ActorDao _singleton = ActorDao.internal();

  factory ActorDao() {
    return _singleton;
  }

  ActorDao.internal();

  void saveAllActors(List<ActorVO> actorList) async {
    Map<int, ActorVO> actorMap = Map.fromIterable(actorList,
        key: (actor) => actor.id, value: (actor) => actor);
    await getActorBox().putAll(actorMap);
  }
  List<ActorVO> getAllActors(){
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox(){
  return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }
}
