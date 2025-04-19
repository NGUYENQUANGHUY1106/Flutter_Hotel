import 'dart:convert';

class Jwtutil {
  static List<String> getRoles(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = parts[1];
    final decoded = utf8.decode(base64Url.decode(base64Url.normalize(payload)));
    final data = json.decode(decoded);

    final roles = data['roles'];
    if (roles is List) {
      return List<String>.from(roles);
    } else {
      return [];
    }
  }
}
