import 'package:json_annotation/json_annotation.dart';

part 'login_params.g.dart';

@JsonSerializable()
class LoginParams {
  String email;
  String password;
  String deviceId;

  LoginParams({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);
  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);
}
