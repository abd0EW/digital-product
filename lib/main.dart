import 'package:app_links/app_links.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/utils/deep_link/deep_link_routes.dart';
import 'package:digital_product/core/utils/deep_link/handle_deep_link.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/viewmodels/confirm_worker_invitation_cubit/confirm_worker_invitation_cubit.dart';
import 'package:digital_product/root.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/email_verification/email_verification_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/login/login_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/logout/logout_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/password/password_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/register/register_cubit.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/user_role/user_role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sdothzkfvdtlrjzzpvdv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNkb3RoemtmdmR0bHJqenpwdmR2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAwNjQwOTgsImV4cCI6MjEwNTY0MDA5OH0.n6w0Z3KkYM002LJd6jBjl9hTn1v-RLVEj8I1S_LNx-0',
  );
  await ServiceLocator.registerDependencies();
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  late final HandleDeepLink _deepLinkHandler;

  @override
  void initState() {
    super.initState();

    _deepLinkHandler = HandleDeepLink(
      appLinks: AppLinks(),
      navigatorKey: _navigatorKey,
      routes: DeepLinkRoutes.routes,
    );

    _deepLinkHandler.initialize();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _deepLinkHandler.navigateToPendingLink();
    });
  }

  @override
  void dispose() {
    _deepLinkHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (_) => ServiceLocator.sl<LoginCubit>(),
        ),
        BlocProvider<RegisterCubit>(
          create: (_) => ServiceLocator.sl<RegisterCubit>(),
        ),
        BlocProvider<LogoutCubit>(
          create: (_) => ServiceLocator.sl<LogoutCubit>(),
        ),
        BlocProvider<UserRoleCubit>(
          create: (_) => ServiceLocator.sl<UserRoleCubit>(),
        ),
        BlocProvider<PasswordCubit>(
          create: (_) => ServiceLocator.sl<PasswordCubit>(),
        ),
        BlocProvider<EmailVerificationCubit>(
          create: (_) => ServiceLocator.sl<EmailVerificationCubit>(),
        ),

        BlocProvider(
          create: (_) => ServiceLocator.sl<ConfirmWorkerInvitationCubit>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        locale: const Locale('ar', 'SA'),
        supportedLocales: const [Locale('ar', 'SA')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: 'Digital Product',
        home: const Root(),
      ),
    );
  }
}
