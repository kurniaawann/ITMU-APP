import 'package:dartz/dartz.dart';
import 'package:mobile_itmu/features/auth/data/models/login_model.dart';
import 'package:mobile_itmu/features/auth/data/models/login_params.dart';
import 'package:mobile_itmu/features/auth/domain/repositories/authentication_repository.dart';
import 'package:mobile_itmu/framework/core/exceptions/failures.dart';
import 'package:mobile_itmu/framework/core/usecase/usecase.dart';

class LoginUsecase implements UseCase<LoginModel, LoginParams> {
  LoginUsecase(this.authenticationRepository);
  final AuthenticationRepository authenticationRepository;

  @override
  Future<Either<Failure, LoginModel>> call(LoginParams params) async {
    return await authenticationRepository.login(params);
  }
}
