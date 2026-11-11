import '../environment/roams_environment.dart';

class RoamsGeneric {

  const RoamsGeneric.___({
    required this.authEndpoint,
    required this.tokenEndpoint,
    required this.clientId,
    required this.scopes,
    required this.redirectUri,
    required this.environment,
  });

  factory RoamsGeneric({ required String srcUrl }) {

    final HostClient client = listClient
        .firstWhere((e) => e.url == srcUrl || e.testUrl == srcUrl,
        orElse: () => throw ArgumentError.value(srcUrl, 'Access denied: unregistered redirect URI: $srcUrl',
    ));

    print("roamsauth -> \n"
        "url: ${client.url},\n"
        "clientId: ${client.clientId},\n"
        "hostType: ${client.hostType},\n"
        "testUrl: ${client.testUrl}");

    return RoamsGeneric.___(
      redirectUri: srcUrl,
      clientId: client.clientId,
      scopes: 'cmm read write',
      environment: RoamsEnvironment.production,
      authEndpoint: 'https://roams.cris.org.in/uaa/oauth/authorize',
      tokenEndpoint: 'https://roams.cris.org.in/uaa/oauth/token',
    );
  }

  final String authEndpoint;
  final String tokenEndpoint;
  final String clientId;
  final String scopes;
  final String redirectUri;
  final RoamsEnvironment environment;
}

final List<HostClient> listClient = [
  HostClient(
    hostType: HostType.LOCAL,
    clientId: "dev-env",
    url: "http://localhost:5555/",
    testUrl: 'http://localhost:5555/',
  ),

  HostClient(
    hostType: HostType.LOCAL,
    clientId: "roams-web-test",
    url: "https://roams.cris.org.in/wateringpkce/",
    testUrl: 'https://roams.cris.org.in/wateringpkce/',
  ),

  HostClient(
    hostType: HostType.RAILCARE,
    clientId: "rail-care-v1",
    url: "https://roams.cris.org.in/railcareV1/",
    testUrl: 'https://roams.cris.org.in/railcaretestV1/',
  ),

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

enum HostType { LOCAL, RAILCARE, CMMDASHBOARD, WATERING, MUCARE, ROAMSAPP }

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
