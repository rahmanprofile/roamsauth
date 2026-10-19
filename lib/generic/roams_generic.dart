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

  factory RoamsGeneric({ RoamsEnvironment environment = RoamsEnvironment.test, String? customRedirectUri }) {
    switch (environment) {
      case RoamsEnvironment.production:
        return RoamsGeneric._(
          authEndpoint: 'https://roams.cris.org.in/uaa/oauth/authorize',
          tokenEndpoint: 'https://roams.cris.org.in/uaa/oauth/token',
          clientId: 'roams-web-test',
          scopes: 'cmm read write',
          redirectUri: customRedirectUri ?? '',
          environment: environment,
        );
      case RoamsEnvironment.test:
        return RoamsGeneric._(
          authEndpoint: 'https://roams.cris.org.in/uaa/oauth/authorize',
          tokenEndpoint: 'https://roams.cris.org.in/uaa/oauth/token',
          clientId: 'roams-web-test',
          scopes: 'cmm read write',
          redirectUri: customRedirectUri ?? '',
          environment: environment,
        );
    }
  }

  final String authEndpoint;
  final String tokenEndpoint;
  final String clientId;
  final String scopes;
  final String redirectUri;
  final RoamsEnvironment environment;

  List<String> get scopeList => scopes.split(' ');
  bool get isValid => authEndpoint.isNotEmpty && tokenEndpoint.isNotEmpty && clientId.isNotEmpty;
}
