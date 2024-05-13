import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  User? getCurrentUser() {
    try {
      return _client.auth.currentUser;
    } catch (e) {
      return null;
    }
  }

  Future<Session?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await _client.auth
          .signInWithPassword(email: email, password: password);

      if (response.session == null) {
        return null;
      }

      return response.session;
    } catch (e) {
      return null;
    }
  }
}
