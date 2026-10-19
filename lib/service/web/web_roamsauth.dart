import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:roamsauth/environment/roams_environment.dart';
import 'package:roamsauth/generic/roams_generic.dart';
import '../built_in_component.dart';
import 'dart:html' as html;

class WebRoamsauth extends StatefulWidget {
  final void Function(Map<String, dynamic> tokens)? onSuccess;
  final void Function(Map<String, dynamic> error)? onError;

  const WebRoamsauth({super.key, this.onSuccess, this.onError});

  @override
  State<WebRoamsauth> createState() => _WebRoamsauthState();
}

class _WebRoamsauthState extends State<WebRoamsauth> {
  late final RoamsGeneric generic;
  late final String redirectUriCtrl;

  Map<String, dynamic> tokenOutput = {};

  String status = '';
  bool isError = false;

  String? _refreshToken;

  @override
  void initState() {
    super.initState();

    final origin = html.window.location.origin;
    final path = html.window.location.pathname ?? '/';
    redirectUriCtrl = '$origin$path';

    generic = RoamsGeneric(
      environment: RoamsEnvironment.test,
      customRedirectUri: redirectUriCtrl,
    );

    _handleCallbackIfPresent();
  }

  Future<void> _handleCallbackIfPresent() async {
    final uri = Uri.parse(html.window.location.href);
    final code = uri.queryParameters['code'];
    final state = uri.queryParameters['state'];
    final error = uri.queryParameters['error'];

    if (error != null) {
      setState(() {
        isError = true;
        status =
            'Authorization error: $error — ${uri.queryParameters['error_description'] ?? ''}';
      });
      return;
    }

    if (code != null) {
      final expectedState = html.window.sessionStorage['pkce_state'];
      if (state != expectedState) {
        setState(() {
          isError = true;
          status = 'State mismatch — possible CSRF, aborting.';
        });
        return;
      }
      setState(() {
        isError = false;
        status = 'Got authorization code, exchanging for token…';
      });
      await _exchangeCodeForToken(code);
      html.window.history.replaceState(null, '', uri.path);
    }
  }

  String _randomUrlSafeString(int length) {
    final rand = Random.secure();
    final values = List<int>.generate(length, (_) => rand.nextInt(256));
    return base64UrlEncode(values).replaceAll('=', '');
  }

  String _codeChallengeFromVerifier(String verifier) {
    final digest = sha256.convert(utf8.encode(verifier));
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }

  Future<void> _login() async {
    final codeVerifier = _randomUrlSafeString(64);
    final codeChallenge = _codeChallengeFromVerifier(codeVerifier);
    final state = _randomUrlSafeString(16);

    html.window.sessionStorage['pkce_code_verifier'] = codeVerifier;
    html.window.sessionStorage['pkce_state'] = state;

    final params = {
      'response_type': 'code',
      'client_id': generic.clientId,
      'redirect_uri': redirectUriCtrl,
      'scope': generic.scopes,
      'state': state,
      'code_challenge': codeChallenge,
      'code_challenge_method': 'S256',
    };

    final authUrl = Uri.parse(
      generic.authEndpoint,
    ).replace(queryParameters: params);
    html.window.location.href = authUrl.toString();
  }

  Future<void> _exchangeCodeForToken(String code) async {
    final codeVerifier = html.window.sessionStorage['pkce_code_verifier'];
    try {
      final response = await http.post(
        Uri.parse(generic.tokenEndpoint),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': redirectUriCtrl,
          'client_id': generic.clientId,
          'code_verifier': codeVerifier ?? '',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          tokenOutput = json;
          _refreshToken = json['refresh_token'] as String?;
          isError = false;
          status = 'Token exchange succeeded';
        });

        html.window.sessionStorage.remove('pkce_code_verifier');
        html.window.sessionStorage.remove('pkce_state');

        widget.onSuccess?.call(json);
      } else {
        Map<String, dynamic> body = {};
        try {
          body = jsonDecode(response.body) as Map<String, dynamic>;
        } catch (_) {
          body = {'raw': response.body};
        }

        final error = {
          'status_code': response.statusCode,
          'message': 'Token exchange failed (HTTP ${response.statusCode})',
          ...body,
        };

        setState(() {
          isError = true;
          status = error['message'] as String;
        });

        widget.onError?.call(error);
      }
    } catch (e) {
      if (!mounted) return;
      final error = {
        'message': 'Token request error: $e (often CORS on the token endpoint)',
      };
      setState(() {
        isError = true;
        status = error['message'] as String;
      });
      widget.onError?.call(error);
    }
  }

  Future<void> _refresh() async {
    if (_refreshToken == null) return;
    try {
      final response = await http.post(
        Uri.parse(generic.tokenEndpoint),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': _refreshToken!,
          'client_id': generic,
        },
      );
      setState(() {
        tokenOutput = response.body as Map<String, dynamic>;
        isError = response.statusCode != 200;
        status = response.statusCode == 200
            ? 'Refresh succeeded'
            : 'Refresh failed (HTTP ${response.statusCode})';
        if (response.statusCode == 200) {
          try {
            final json = jsonDecode(response.body) as Map<String, dynamic>;
            if (json['refresh_token'] != null) {
              _refreshToken = json['refresh_token'] as String;
            }
          } catch (_) {}
        }
      });
    } catch (e) {
      setState(() {
        isError = true;
        status = 'Refresh error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROAMSAUTH ~ CMM GROUP CRIS',
      debugShowCheckedModeBanner: false,
      home: BuiltInComponent(onLogin: _login, onRefresh: _refresh),
    );
  }
}
