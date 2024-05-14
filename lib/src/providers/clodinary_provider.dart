import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/services/cloudinary_service.dart';

class CloudinaryProvider extends ChangeNotifier {
  final _cloudinaryService = CloudinaryService();

  String? _secureUrl;

  String? get secureUrl => _secureUrl;

  Future<void> uploadImage(String path) async {
    final secureUrl = await _cloudinaryService.uploadImage(path);
    if (secureUrl != null) {
      _secureUrl = secureUrl;
      notifyListeners();
    }
  }

  void clearSecureUrl() {
    _secureUrl = null;
    notifyListeners();
  }
}
