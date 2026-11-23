
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // REGISTER
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // LOGIN
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // LOGOUT
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // MEMANTAU STATUS LOGIN
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  // MENGAMBIL USER YANG SEDANG LOGIN
  User? get currentUser => _firebaseAuth.currentUser;
}
