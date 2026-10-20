import 'package:app_links/app_links.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/features/dashboard_owner/payments/presentation/views/owner_payments_view.dart';
import 'package:digital_product/root.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_cubit.dart';
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
  final GlobalKey<NavigatorState> _navigatorState = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initDeeplink();
  }

  Future<void> initDeeplink() async {
    final appLink = AppLinks();

    final initialLink = await appLink.getInitialLink();
    if (initialLink != null) handleIncomingLink(initialLink);

    appLink.uriLinkStream.listen((uri) {
      handleIncomingLink(uri);
    });
  }

  void handleIncomingLink(Uri uri) {
    if (uri.scheme == 'digitalproduct' && uri.host == 'invite_email') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OwnerPaymentsView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.sl<AuthCubit>(),
      child: MaterialApp(
        key: _navigatorState,
        locale: const Locale('ar', 'SA'),
        supportedLocales: [const Locale('ar', 'SA')],
        localizationsDelegates: [
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
