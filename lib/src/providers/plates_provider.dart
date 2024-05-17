import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/entities/plates.dart';
import 'package:smartaccess_app/src/services/plates_service.dart';
import 'package:smartaccess_app/src/services/firebase_auth_service.dart';

class PlatesProvider extends ChangeNotifier {
  final _platesService = PlateService();
  final _firebaseAuthService = FirebaseAuthService();

  List<CheckIn>? _plateData;

  List<CheckIn>? get plateData => _plateData;

  Future<void> getPlateData() async {
    final token = await _firebaseAuthService.currentUser?.getIdToken();
    if (token != null) {
      print('Token: $token');
      _plateData = await _platesService.getPlate(token);
      notifyListeners();
    }
  }
}