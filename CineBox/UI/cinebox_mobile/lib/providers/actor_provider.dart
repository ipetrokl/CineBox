import 'package:cinebox_mobile/models/Actor/actor.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class ActorProvider extends BaseProvider<Actor> {
  ActorProvider() : super("Actor");

  @override
  Actor fromJson(data) {
    return Actor.fromJson(data);
  }
}