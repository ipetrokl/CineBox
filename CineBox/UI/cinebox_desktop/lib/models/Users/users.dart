import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class Users {
  int? id;
  String? name;
  String? surname;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? passwordConfirmation;
  bool? status;

  Users(this.id, this.name, this.surname, this.email, this.phone, this.username,
      this.password, this.passwordConfirmation, this.status);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
