import 'dart:convert';

import 'package:cinebox_desktop/models/UsersRole/usersRole.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;


class UsersRoleProvider extends BaseProvider<UsersRole> {
  UsersRoleProvider() : super("UsersRole");

  @override
  UsersRole fromJson(data) {

    return UsersRole.fromJson(data);
  }

  @override
  Future<UsersRole> insert(request) async {
    var url = "${BaseProvider.baseUrl}UsersRole";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(
        {...request, 'dateOfModification': request['dateOfModification']?.toIso8601String()});

    // var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  @override
  Future<UsersRole> update(int id, [request]) async {
    var url = "${BaseProvider.baseUrl}UsersRole/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(
        {...request, 'dateOfModification': request['dateOfModification'].toIso8601String()});

    // var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }
}