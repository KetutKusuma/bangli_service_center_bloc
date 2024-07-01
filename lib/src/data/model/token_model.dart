import 'package:bangli_service_center_bloc/src/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel({
    String? accessToken,
    String? refreshToken,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['token'],
      refreshToken: json['refresh_token'],
    );
  }
  factory TokenModel.fromJsonAPI(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return '''{
              'access_token' : $accessToken,
              'refresh_token' : $refreshToken,
            }''';
  }
}
