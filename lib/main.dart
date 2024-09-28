import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_itmu/app.dart';
import 'package:mobile_itmu/framework/core/observer/bloc_observer.dart';
import 'package:mobile_itmu/service_locator.dart';

void main() async {
  /// Ensures that widget binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// Loads environment variables from the `.env` file.
  await dotenv.load(fileName: ".env");

  /// Sets the global [BlocObserver] for the app.
  Bloc.observer = SimpleBlocObserver();

  /// Initializes the dependency injection system.
  await initDependencyInjection();
  runApp(const MyApp());
}
