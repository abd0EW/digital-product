import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class HandleDeepLink {
  HandleDeepLink({
    required this.appLinks,
    required this.navigatorKey,
    required this.routes,
  });

  final AppLinks appLinks;
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, WidgetBuilder> routes;
  StreamSubscription<Uri>? _subscription;
  Uri? _pendingUri;

  Future<void> initialize() async {
    _subscription ??= appLinks.uriLinkStream.listen(handleIncomingLink);

    final initialUri = await appLinks.getInitialLink();

    if (initialUri != null) {
      handleIncomingLink(initialUri);
    }
  }

  void handleIncomingLink(Uri uri) {
    if (uri.scheme != 'digitalproduct') return;

    if (!routes.containsKey(uri.host)) return;

    _pendingUri = uri;
    navigateToPendingLink();
  }

  void navigateToPendingLink() {
    final uri = _pendingUri;
    final navigator = navigatorKey.currentState;

    if (uri == null || navigator == null) return;

    final builder = routes[uri.host];
    if (builder == null) return;

    _pendingUri = null;

    navigator.push(MaterialPageRoute(builder: builder));
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }
}
