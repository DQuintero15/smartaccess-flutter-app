import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/entities/detection.dart';
import 'package:smartaccess_app/src/services/detection_service.dart';
import 'package:smartaccess_app/src/services/firebase_auth_service.dart';

class DetectionProvider extends ChangeNotifier {
  final _detectionService = DetectionService();
  final _firebaseAuthService = FirebaseAuthService();

  Detection? result;

  Detection? get detectionResult => result;

  Future<void> getDetection(String secureUrl) async {
    final token = await _firebaseAuthService.currentUser?.getIdToken();

    if(token == null) {
      return;
    }

    final detection = await _detectionService.getDetection(token, secureUrl);
    if (detection != null) {
      result = detection;
      notifyListeners();
    }
  }

  void clearDetection() {
    result = null;
    notifyListeners();
  }
}
