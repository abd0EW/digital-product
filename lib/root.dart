import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/utils/role_navigation_resolver.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:digital_product/features/auth/presentation/views/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _isChecking = true;
  Object? _error;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUser();
    });
  }

  Future<void> _checkUser() async {
    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        setState(() {
          _isChecking = false;
        });
        return;
      }

      final UserRole role = await ServiceLocator.sl<AuthCubit>()
          .getCurrentUserRole();

      if (!mounted) return;

      RoleNavigationResolver.resolve(context, role);
    } catch (error, stackTrace) {
      debugPrint('Root initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        _error = error;
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('حدث خطأ أثناء تحميل بيانات المستخدم'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isChecking = true;
                    _error = null;
                  });

                  _checkUser();
                },
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    return const AuthView();
  }
}
