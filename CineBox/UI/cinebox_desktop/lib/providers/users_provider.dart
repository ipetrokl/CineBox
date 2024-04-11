import 'package:cinebox_desktop/models/Users/users.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class UsersProvider extends BaseProvider<Users> {
  UsersProvider() : super("Users");

  @override
  Users fromJson(data) {

    return Users.fromJson(data);
  }
}