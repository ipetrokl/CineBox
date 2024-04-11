import 'package:cinebox_desktop/models/Actor/actor.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class ActorProvider extends BaseProvider<Actor> {
  ActorProvider() : super("Actor");

  @override
  Actor fromJson(data) {

    return Actor.fromJson(data);
  }
}