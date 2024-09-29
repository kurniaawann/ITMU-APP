import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_itmu/framework/core/style/app_colors.dart';

class AppTheme {
  static bool isDarkMode(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark;
  }

  static bool isLightMode(BuildContext context) => !isDarkMode(context);

  static ThemeData get lightTheme {
    final ThemeData base = ThemeData.light().copyWith(
      brightness: Brightness.light,

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.unselectedColor,
      ),
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      // cardTheme: const CardTheme(
      //   color: AppColors.secondGreyColor,
      // ),
      // checkboxTheme: const CheckboxThemeData(
      //   fillColor: WidgetStatePropertyAll(AppColors.greyColor),
      // ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
    return _buildTheme(base);
  }

  static ThemeData _buildTheme(ThemeData base) {
    return base.copyWith(
      textTheme: _buildTextTheme(base),
      // iconTheme: _buildIconTheme(base),
      // cardTheme: _buildCardTheme(base),
      // textButtonTheme: _textButtonTheme(base),
    );
  }

  // static IconThemeData _buildIconTheme(ThemeData base) =>
  //     base.iconTheme.copyWith(color: base.colorScheme.primary);

  // static TextButtonThemeData _textButtonTheme(ThemeData base) =>
  //     TextButtonThemeData(
  //       style: TextButton.styleFrom(
  //         textStyle: base.textTheme.bodyMedium?.copyWith(
  //           color: AppColors.primaryColor,
  //           fontWeight: FontWeight.w700,
  //         ),
  //       ),
  //     );

  // static CardTheme _buildCardTheme(ThemeData base) => base.cardTheme.copyWith(
  //       margin: EdgeInsets.zero,
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //     );

  static TextTheme _buildTextTheme(ThemeData base) {
    final textTheme = base.textTheme;
    return GoogleFonts.interTextTheme(textTheme)
        .copyWith(
          titleLarge: textTheme.titleLarge
              ?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          headlineMedium: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
          headlineSmall: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        )
        .apply(
          fontFamily: 'Inter',
          displayColor: AppColors.blackColor,
          bodyColor: AppColors.blackColor,
        );
  }
}
