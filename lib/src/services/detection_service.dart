import 'dart:convert';

import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class DetectionService {
  final apiUrl = "${AppConstants.apiBaseUrl}/detections";

  Future<String?> getDetection(String token, String secureUrl) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"image_url": secureUrl}),
    );

    if (response.statusCode == 200) {
      final detection = response.body;
      return detection;
    } else {
      return null;
    }
  }
}
