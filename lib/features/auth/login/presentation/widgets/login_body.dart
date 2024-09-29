import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_itmu/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:mobile_itmu/features/auth/login/presentation/validation/login_validator.dart';
import 'package:mobile_itmu/framework/core/config/string_resource.dart';
import 'package:mobile_itmu/framework/core/style/app_colors.dart';
import 'package:mobile_itmu/framework/managers/helper.dart';
import 'package:mobile_itmu/framework/widgets/itindo_text_field.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    if (kDebugMode) {
      _emailController.text = 'radenkurni123@gmail.com';
      _passwordController.text = 'Bakur12345.';
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/itmu.png'),
            Text(
              StringResources.APP_NAME,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              StringResources.WELCOME,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40),
            ItindoTextField(
              formKey: _formKeys[0],
              onChanged: (value) => LoginValidator.validateEmail(value),
              validator: (value) {
                return LoginValidator.validateEmail(value);
              },
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Masukan Email',
            ),
            const SizedBox(height: 20),
            ItindoTextField(
              formKey: _formKeys[1],
              onChanged: (value) => LoginValidator.validatePassword(value),
              validator: (value) => LoginValidator.validatePassword(value),
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Masukan Kata Sandi',
              isPassword: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Password',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                printError(state);
                if (state is LoginSuccessState) {
                  // context.pushNamed(Routes.home);
                } else if (state is LoginFailureState) {
                  printError(state.message);
                  showSnackBar(
                    context,
                    state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blackColor,
                    ),
                  );
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      bool allValid = _formKeys
                          .every((key) => key.currentState!.validate());
                      if (allValid) {
                        context.read<LoginBloc>().add(LoginSubmitEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              deviceId: 'Test',
                            ));
                      }
                    },
                    child: Text(
                      'Masuk',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
