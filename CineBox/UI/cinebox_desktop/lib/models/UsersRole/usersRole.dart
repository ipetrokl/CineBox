import 'package:json_annotation/json_annotation.dart';

part 'usersRole.g.dart';

@JsonSerializable()
class UsersRole {
  int? usersRolesId;
  int? userId;
  int? roleId;
  DateTime? dateOfModification;

  UsersRole(this.usersRolesId, this.userId, this.roleId, this.dateOfModification);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UsersRole.fromJson(Map<String, dynamic> json) => _$UsersRoleFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UsersRoleToJson(this);
}