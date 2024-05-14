import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final uploadUrl = Uri.parse(
      'https://api.cloudinary.com/v1_1/${AppConstants.cloudName}/image/upload');

  Future<String?> uploadImage(String path) async {
    final request = http.MultipartRequest('POST', uploadUrl)
      ..fields['upload_preset'] = AppConstants.uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final secureUrl = responseData.split('secure_url":"')[1].split('"')[0];

      return secureUrl;
    } else {
      return null;
    }
  }
}
