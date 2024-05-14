import 'dart:convert';

import 'package:smartaccess_app/src/dtos/business.dart';
import 'package:smartaccess_app/src/entities/business.dart';
import 'package:http/http.dart' as http;
import 'package:smartaccess_app/src/utils/app_constants.dart';

class BusinessService {
  final apiUrl = "${AppConstants.apiBaseUrl}businesses";

  Future<Business?> registerBusiness(
      BusinessDto businessDto, String token) async {
    final response = await http.post(
      Uri.parse('${AppConstants.apiBaseUrl}/businesses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(businessDto.toJson()),
    );

    if (response.statusCode == 201) {
      return Business(
        name: businessDto.name,
        email: businessDto.email,
        owner: businessDto.owner,
        coastPerMinute: businessDto.coastPerMinute,
      );
    } else {
      return null;
    }
  }
}
