import 'package:http/http.dart' as http;

class RoamsauthController {

  static const String _url = "https://roams.cris.org.in/uaa/logout";

  Future<bool> logout() async {
    try {
      final response = await http.get(Uri.parse(_url),
        headers: {"Accept": "application/json"},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
