import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:smartaccess_app/src/dtos/plates.dart';
import 'package:smartaccess_app/src/entities/plates.dart';

class PlateService {
  final apiUrl = "${AppConstants.apiBaseUrl}/plates";

  Future<CheckIn?> getPlate(String token) async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final plate = CheckIn.fromJson(jsonDecode(response.body));
      return plate;
    } else {
      return null;
    }
  }
}

// const PlateService {
//   final apiUrl = "${AppConstants.apiBaseUrl}/plates";

  
// }