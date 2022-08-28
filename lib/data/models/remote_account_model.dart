import '../../domain/entities/account_entities.dart';
import '../http/http.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('accessToken')) throw HttpError.invalidData;
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
