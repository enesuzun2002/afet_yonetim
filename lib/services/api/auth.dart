import 'dart:convert';

import 'package:afet_yonetim/model/user.dart';
import 'package:http/http.dart';

import '../../constants.dart';

class AuthAPI {
  Future<UserModel> register(
      int idNumber, String name, String surname, int birthYear) async {
    try {
      var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};

      var body = {
        "idNumber": idNumber,
        "name": name.toUpperCase(),
        "surname": surname.toUpperCase(),
        "birthyear": birthYear
      };

      var req = Request('POST', Uri.parse("${Constants.endpoint}/signup"));
      req.headers.addAll(headersList);
      req.body = json.encode(body);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        UserModel user = UserModel.fromMap(jsonDecode(resBody)["user"]);
        user.token = jsonDecode(resBody)["token"];
        return user;
      } else {
        throw Exception(res.reasonPhrase);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> login(int idNumber, String name) async {
    try {
      var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};

      var body = {"idNumber": idNumber, "name": name.toUpperCase()};
      var req = Request('POST', Uri.parse("${Constants.endpoint}/login"));
      req.headers.addAll(headersList);
      req.body = json.encode(body);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        UserModel user = UserModel.fromMap(jsonDecode(resBody)["user"]);
        user.token = jsonDecode(resBody)["token"];
        return user;
      } else {
        throw Exception(res.reasonPhrase);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
