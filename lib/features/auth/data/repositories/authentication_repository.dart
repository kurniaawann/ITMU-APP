import 'package:dartz/dartz.dart';
import 'package:mobile_itmu/features/auth/data/datasources/authentication_local_datasource.dart';
import 'package:mobile_itmu/features/auth/data/datasources/authentication_remote_datasource.dart';
import 'package:mobile_itmu/features/auth/data/models/login_model.dart';
import 'package:mobile_itmu/features/auth/data/models/login_params.dart';
import 'package:mobile_itmu/features/auth/domain/repositories/authentication_repository.dart';
import 'package:mobile_itmu/framework/core/config/string_resource.dart';
import 'package:mobile_itmu/framework/core/exceptions/app_exceptions.dart';
import 'package:mobile_itmu/framework/core/exceptions/failures.dart';
import 'package:mobile_itmu/framework/network/network.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.authenticationLocalDatasource,
  });

  final AuthenticationRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthenticationLocalDatasource authenticationLocalDatasource;
  @override
  Future<Either<Failure, LoginModel>> login(LoginParams loginParams) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.login(loginParams);
        authenticationLocalDatasource.saveRefreshToken(user.refreshToken);
        return Right(user);
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(e.toString()));
      } on UnauthorisedException catch (e) {
        return Left(UnauthorisedFailure(e.toString()));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.toString()));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on InvalidCredentialException catch (e) {
        return Left(InvalidCredentialFailure(e.toString()));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on NetworkException {
        return const Left(
            NetworkFailure(StringResources.NETWORK_FAILURE_MESSAGE));
      }
    } else {
      return const Left(
          NetworkFailure(StringResources.NETWORK_FAILURE_MESSAGE));
    }
  }
}
