import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthNetworkDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthNetworkDatasourceImpl implements AuthNetworkDatasource {
  final FirebaseAuth _firebaseAuth;

  AuthNetworkDatasourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update display name
      await userCredential.user?.updateDisplayName(name);
      
      // Re-fetch user so displayName is populated
      await _firebaseAuth.currentUser?.reload();
      final updatedUser = _firebaseAuth.currentUser;
      
      return UserModel.fromFirebaseUser(updatedUser!);
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }
  
  Exception _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found for that email.');
      case 'wrong-password':
        return Exception('Wrong password provided.');
      case 'email-already-in-use':
        return Exception('The account already exists for that email.');
      case 'invalid-email':
        return Exception('The email address is not valid.');
      case 'weak-password':
        return Exception('The password provided is too weak.');
      default:
        return Exception(e.message ?? 'An unknown error occurred.');
    }
  }
}
