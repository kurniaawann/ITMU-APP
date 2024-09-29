part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;
  final String deviceId;
  const LoginSubmitEvent(
      {required this.email, required this.password, required this.deviceId});
}
