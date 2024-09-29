import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_itmu/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:mobile_itmu/features/auth/login/presentation/widgets/login_body.dart';
import 'package:mobile_itmu/service_locator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(),
        body: const LoginBody(),
      ),
    );
  }
}
