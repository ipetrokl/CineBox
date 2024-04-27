import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:cinebox_mobile/providers/base_provider.dart';

class UsersProvider extends BaseProvider<Users> {
  UsersProvider() : super("Users");

 @override
  Users fromJson(data) {
    return Users.fromJson(data);
  }
}