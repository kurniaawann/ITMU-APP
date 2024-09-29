import 'package:dartz/dartz.dart';
import 'package:mobile_itmu/features/auth/data/models/login_model.dart';
import 'package:mobile_itmu/features/auth/data/models/login_params.dart';
import 'package:mobile_itmu/framework/core/exceptions/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginModel>> login(LoginParams loginParams);
}
