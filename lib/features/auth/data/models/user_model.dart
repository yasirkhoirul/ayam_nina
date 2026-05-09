import '../../domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    super.name,
  });

  factory UserModel.fromFirebaseUser(firebase.User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName,
    );
  }
}
