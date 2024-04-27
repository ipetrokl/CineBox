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

  Users();

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}