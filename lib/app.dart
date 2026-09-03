import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_colors.dart';
import 'features/auth/presentation/views/auth_welcome_view.dart';

class DigitalProductApp extends StatelessWidget {
  const DigitalProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: const Locale('ar'),

      supportedLocales: const [Locale('ar')],

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.navyPrimary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.appBackground,
        useMaterial3: true,
      ),

      home: const AuthWelcomeView(),
    );
  }
}
