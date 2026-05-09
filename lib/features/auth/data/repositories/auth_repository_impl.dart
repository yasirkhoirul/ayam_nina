import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_network_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthNetworkDatasource networkDatasource;

  AuthRepositoryImpl(this.networkDatasource);

  @override
  Future<UserEntity> login(String email, String password) async {
    return await networkDatasource.login(email, password);
  }

  @override
  Future<UserEntity> register(String email, String password, String name) async {
    return await networkDatasource.register(email, password, name);
  }

  @override
  Future<void> logout() async {
    return await networkDatasource.logout();
  }
  
  @override
  Future<UserEntity?> getCurrentUser() async {
    return await networkDatasource.getCurrentUser();
  }
}
