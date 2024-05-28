import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:smartaccess_app/src/entities/plates.dart';

class PlateService {
  final apiUrl = "${AppConstants.apiBaseUrl}/plates";


  Future<List<CheckIn>?> getNonCheckInPlates(String token) async {
    final response = await http.get(
      Uri.parse("$apiUrl/non-check-in"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<CheckIn> plates = jsonResponse.map((json) => CheckIn.fromJson(json)).toList();
      return plates;
    } else {
      return null;
    }
  }

  Future<bool?> createPlate(String token, String plate) async {
    final response = await http.post(
      Uri.parse("$apiUrl/app"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"plate": plate, "checkInSource": "MANUAL"}),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<CheckIn>?> getPlate(String token) async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<CheckIn> plates = jsonResponse.map((json) => CheckIn.fromJson(json)).toList();
      return plates;
    } else {
      return null;
    }
  }
}
