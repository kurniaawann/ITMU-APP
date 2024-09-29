import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  @JsonKey(name: "accessToken")
  final String accessToken;
  @JsonKey(name: "refreshToken")
  final String refreshToken;

  const LoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}
