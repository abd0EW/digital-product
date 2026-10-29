enum DeepLinkType {
  inviteEmailHost(urlHost: 'invite_email', destination: 'workerLogin');

  const DeepLinkType({required this.urlHost, required this.destination});

  final String urlHost;
  final String destination;

  static DeepLinkType? fromUri(Uri uri) {
    if (uri.scheme != 'digitalproduct') return null;

    for (final type in DeepLinkType.values) {
      if (uri.host == type.urlHost) {
        return type;
      }
    }
    return null;
  }
}
