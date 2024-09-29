import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_itmu/features/auth/data/models/login_params.dart';
import 'package:mobile_itmu/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUsecase;
  LoginBloc(this._loginUsecase) : super(LoginInitial()) {
    on<LoginSubmitEvent>((event, emit) async {
      emit(LoginLoadingState());
      final result = await _loginUsecase.call(LoginParams(
        email: event.email,
        password: event.password,
        deviceId: event.deviceId,
      ));

      result.fold(
        (failure) => emit(
          LoginFailureState(message: failure.message),
        ),
        (success) => emit(
          LoginSuccessState(),
        ),
      );
    });
  }
}
