import 'package:flutter/material.dart';
import 'package:mobile_itmu/framework/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerDelegate,
    );
  }
}
