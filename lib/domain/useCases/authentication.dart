import '../entities/account_entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth({required String email, required String password});
}
