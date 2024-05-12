import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  Future<Session?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await _client.auth
          .signInWithPassword(email: email, password: password);

      if (response.session == null) {
        
        Fluttertoast.showToast(
          msg: 'Correo o contraseña incorrectos',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return null;
      }

      return response.session;
    } catch (e) {
      return null;
    }
  }
}
