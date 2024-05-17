import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:smartaccess_app/src/entities/plates.dart';

class PlateService {
  final apiUrl = "${AppConstants.apiBaseUrl}/plates";

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
