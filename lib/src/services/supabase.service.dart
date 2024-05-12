import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  Future<Session?> signInWithEmailAndPassword(
      String email, String password) async {
    final response =
        await _client.auth.signInWithPassword(email: email, password: password);
    if (response.user != null && response.session != null) {
      return response.session;
    } else {
      return null;
    }
  }
}
