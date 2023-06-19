import 'dart:convert';

import 'package:afet_yonetim/services/provider/auth.dart';
import 'package:afet_yonetim/values.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../constants.dart';
import '../../model/location.dart';

class LocationAPI {
  LocationAPI(this.ref);

  final Ref ref;

  Future<void> setLocation(LocationModel model) async {
    try {
      var headersList = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': currentUser!.token,
      };

      var body = {
        "phoneNumber": model.phoneNumber,
        "mediaLink": model.photo,
        "latitude": model.latitude,
        "longitude": model.longitude,
        "userID": model.userID
      };

      var req = Request(
          'POST', Uri.parse("${Constants.endpoint}/yardimaihtiyacimvar"));
      req.headers.addAll(headersList);
      req.body = json.encode(body);

      var res = await req.send();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return;
      } else if (res.statusCode == 401) {
        // Relog with current credentials and get new token
        await ref.read(
            loginProvider([currentUser!.idNumber, currentUser!.name]).future);
        return setLocation(model);
      } else {
        throw Exception(res.reasonPhrase);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<List<LocationModel>> getLocations() async {
    Response response = await get(
      Uri.parse("${Constants.endpoint}/yardimedebilirim"),
      headers: {"Authorization": currentUser!.token},
    );
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => LocationModel.fromMap(e)).toList();
    } else if (response.statusCode == 401) {
      // Relog with current credentials and get new token
      await ref.read(
          loginProvider([currentUser!.idNumber, currentUser!.name]).future);
      return getLocations();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
