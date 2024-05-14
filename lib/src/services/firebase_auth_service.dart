import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartaccess_app/src/services/logger_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _logger = LoggerService('FirebaseAuthService');

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _logger.error('Failed to create user: ${e.message}');
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser?.reload();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _logger.error('Failed to sign in: ${e.message}');
      return null;
    }
  }
}
