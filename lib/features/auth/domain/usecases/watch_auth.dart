import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedai_ayam_nina/features/auth/domain/repositories/auth_repository.dart';

class WatchAuth {
  final AuthRepository authRepository;
  const WatchAuth(this.authRepository);

  Stream<User?> call(){
    return authRepository.watchAuth();
  }
}