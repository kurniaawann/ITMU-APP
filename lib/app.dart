import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_itmu/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:mobile_itmu/framework/core/style/app_theme.dart';
import 'package:mobile_itmu/framework/routes/app_pages.dart';
import 'package:mobile_itmu/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator.get<LoginBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: routerDelegate,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}

// class AuthProvider with ChangeNotifier {
//   bool _isLoggedIn = false;

//   bool get isLoggedIn => _isLoggedIn;

//   void login() {
//     _isLoggedIn = true;
//     notifyListeners();
//   }

//   void logout() {
//     _isLoggedIn = false;
//     notifyListeners();
//   }
// }
