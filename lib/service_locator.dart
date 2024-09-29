import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_itmu/features/auth/data/datasources/authentication_local_datasource.dart';
import 'package:mobile_itmu/features/auth/data/datasources/authentication_remote_datasource.dart';
import 'package:mobile_itmu/features/auth/data/repositories/authentication_repository.dart';
import 'package:mobile_itmu/features/auth/domain/repositories/authentication_repository.dart';
import 'package:mobile_itmu/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_itmu/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:mobile_itmu/framework/core/observer/custom_route_observer.dart';
import 'package:mobile_itmu/framework/managers/http_managers.dart';
import 'package:mobile_itmu/framework/managers/secure_storage_config/secure_storage_db_service.dart';
import 'package:mobile_itmu/framework/network/network.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initDependencyInjection() async {
  serviceLocator.registerSingleton<CustomRouteObserver>(CustomRouteObserver());
  serviceLocator.registerLazySingleton<HttpManager>(() => AppHttpManager());

  //!data source
  serviceLocator.registerLazySingleton<AuthenticationRemoteDatasource>(
    () => AuthenticationRemoteDatasourceImpl(httpManager: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthenticationLocalDatasource>(
    () => AuthenticationLocalDatasourceImpl(
        secureStorageDbService: serviceLocator()),
  );

  //!repository
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
        remoteDataSource: serviceLocator(),
        networkInfo: serviceLocator(),
        authenticationLocalDatasource: serviceLocator()),
  );

  //!usecase
  serviceLocator.registerLazySingleton(
    () => LoginUsecase(serviceLocator()),
  );

  //!login Bloc
  serviceLocator.registerFactory(
    () => LoginBloc(serviceLocator()),
  );
  //!network
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()));

  //!storage
  serviceLocator.registerLazySingleton(
    () => SecureStorageDbService(),
  );

  // //!auth
  // serviceLocator.registerLazySingleton<AuthProvider>(() => AuthProvider());
}
