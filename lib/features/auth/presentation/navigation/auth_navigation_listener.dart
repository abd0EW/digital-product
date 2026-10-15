import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthNavigationListener {
  StreamSubscription<AuthState>? _subscription;

  void listenPasswordRecovery({required Function() onRecovery}) {
    _subscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      print("************33333********************************");
      if (data.event == AuthChangeEvent.passwordRecovery) {
        print("************************44444444********************");
        onRecovery();
        print("*******************66666666666666*************************");
      }
      print(data.event);
    });
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
