import '../environment/roams_environment.dart';

class RoamsGeneric {
  const RoamsGeneric._({
    required this.authEndpoint,
    required this.tokenEndpoint,
    required this.clientId,
    required this.scopes,
    required this.redirectUri,
    required this.environment,
  });

  factory RoamsGeneric({
    RoamsEnvironment environment = RoamsEnvironment.test,
    String? customRedirectUri,
  }) {
    final redirectUri = customRedirectUri;
    final client = listClient.cast<HostClient?>().firstWhere(
      (e) =>
          e != null &&
          (environment == RoamsEnvironment.production
              ? e.url == redirectUri
              : e.testUrl == redirectUri),
      orElse: () => null,
    );

    if (client == null) {
      throw ArgumentError.value(
        customRedirectUri,
        '[Custom Redirect Url]',
        'Access denied: unregistered redirect URI.',
      );
    }

    return RoamsGeneric._(
      authEndpoint: 'https://roams.cris.org.in/uaa/oauth/authorize',
      tokenEndpoint: 'https://roams.cris.org.in/uaa/oauth/token',
      clientId: client.clientId,
      scopes: 'cmm read write',
      redirectUri: redirectUri!,
      environment: environment,
    );
  }

  final String authEndpoint;
  final String tokenEndpoint;
  final String clientId;
  final String scopes;
  final String redirectUri;
  final RoamsEnvironment environment;

  List<String> get scopeList => scopes.split(' ');

  bool get isValid =>
      authEndpoint.isNotEmpty &&
      tokenEndpoint.isNotEmpty &&
      clientId.isNotEmpty;
}

final List<HostClient> listClient = [
  HostClient(
    hostType: HostType.RAILCARE,
    clientId: "rail-care",
    url: "https://roams.cris.org.in/railcare/",
    testUrl: 'https://roams.cris.org.in/railcaretest/',
  ),

  HostClient(
    hostType: HostType.ROAMSAPP,
    clientId: "roams-app",
    url: "https://roams.cris.org.in/roamsapp/",
    testUrl: 'https://roams.cris.org.in/roamsapptest/',
  ),

  HostClient(
    hostType: HostType.CMMDASHBOARD,
    clientId: "cmm-dashboard",
    url: "https://roams.cris.org.in/cmmdashboard/",
    testUrl: 'https://roams.cris.org.in/cmmdashboardtest/',
  ),

  HostClient(
    hostType: HostType.MUCARE,
    clientId: "mu-care",
    url: "https://roams.cris.org.in/mucare/",
    testUrl: 'https://roams.cris.org.in/mucaretest/',
  ),

  HostClient(
    hostType: HostType.WATERING,
    clientId: "watering-dashboard",
    url: "https://roams.cris.org.in/wateringdashboard/",
    testUrl: 'https://roams.cris.org.in/wateringdashboard/',
  ),
];

enum HostType { RAILCARE, CMMDASHBOARD, WATERING, MUCARE, ROAMSAPP }

class HostClient {
  final String url;
  final String testUrl;
  final String clientId;
  final HostType hostType;

  const HostClient({
    required this.url,
    required this.clientId,
    required this.testUrl,
    required this.hostType,
  });
}
