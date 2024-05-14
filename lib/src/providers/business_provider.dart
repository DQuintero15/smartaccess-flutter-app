import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/entities/business.dart';
import 'package:smartaccess_app/src/services/business_service.dart';
import 'package:smartaccess_app/src/services/firebase_auth_service.dart';

class BusinessProvider extends ChangeNotifier {
  final BusinessService _businessService = BusinessService();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  Business? _businessData;

  Business? get businessData => _businessData;

  Future<void> getBusinessData() async {
    final token = await _firebaseAuthService.currentUser?.getIdToken();
    if (token != null) {
      _businessData = await _businessService.getBusiness(token);
      notifyListeners();
    }
  }
}