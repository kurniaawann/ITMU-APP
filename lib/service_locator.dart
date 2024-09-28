import 'package:get_it/get_it.dart';
import 'package:mobile_itmu/framework/core/observer/custom_route_observer.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initDependencyInjection() async {
  serviceLocator.registerSingleton<CustomRouteObserver>(CustomRouteObserver());
}
