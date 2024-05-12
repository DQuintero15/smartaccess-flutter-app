import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client =
      SupabaseClient(AppConstants.supabaseUrl, AppConstants.supabaseKey);

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
