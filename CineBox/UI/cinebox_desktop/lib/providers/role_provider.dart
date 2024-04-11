import 'package:cinebox_desktop/models/Role/role.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';


class RoleProvider extends BaseProvider<Role> {
  RoleProvider() : super("Role");

  @override
  Role fromJson(data) {

    return Role.fromJson(data);
  }
}