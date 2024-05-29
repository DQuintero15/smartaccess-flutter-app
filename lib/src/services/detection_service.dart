import 'dart:convert';

import 'package:smartaccess_app/src/entities/detection.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class DetectionService {
  final apiUrl = "${AppConstants.apiBaseUrl}/detections";

  Future<AppDetection?> verifyDetection(String token, String plate) async {
    final response = await http.post(
      Uri.parse("${AppConstants.apiBaseUrl}/plates/check-out-app"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode({"plate": plate}),
    );

    if (response.statusCode == 200) {
      final detection = response.body;
      final detectionJson = jsonDecode(detection);
      final detectionEntity = AppDetection.fromJson(detectionJson);

      return detectionEntity;
    } else {
      return null;
    }
  }

  Future<Detection?> getDetection(String token, String secureUrl) async {
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
      final detectionJson = jsonDecode(detection);
      final detectionEntity = Detection.fromJson(detectionJson);

      return detectionEntity;
    } else {
      return null;
    }
  }
}
