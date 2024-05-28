import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/entities/plates.dart';
import 'package:smartaccess_app/src/services/plates_service.dart';
import 'package:smartaccess_app/src/services/firebase_auth_service.dart';

class PlatesProvider extends ChangeNotifier {
  final _platesService = PlateService();
  final _firebaseAuthService = FirebaseAuthService();

  bool? _plateCreated;

  List<CheckIn>? _plateData;

  List<CheckIn>? get plateData => _plateData;

  List<CheckIn>? _nonCheckInPlates;

  List<CheckIn>? get nonCheckInPlates => _nonCheckInPlates;
  

  bool? get plateCreated => _plateCreated;

  Future<void> getNonCheckInPlates() async {
    final token = await _firebaseAuthService.currentUser?.getIdToken();
    if (token != null) {
      _nonCheckInPlates = await _platesService.getNonCheckInPlates(token);
      notifyListeners();
    }
  }

  Future<void> createPlate(String plate) async {
    final token = await _firebaseAuthService.currentUser?.getIdToken();
    if (token != null) {
      _plateCreated = await _platesService.createPlate(token, plate);
      notifyListeners();
    }
  }

  Future<void> getPlateData() async {
    final token = await _firebaseAuthService.currentUser?.getIdToken();
    if (token != null) {
      print('Token: $token');
      _plateData = await _platesService.getPlate(token);
      notifyListeners();
    }
  }
}