import 'package:http/http.dart';

// ignore: avoid_classes_with_only_static_members
class Login {
  static String oscaUrl =
      'https://osca-bew.hs-osnabrueck.de/scripts/mgrqispi.dll';

  static Future<LoginResult> login(
      Client client, String username, String password) async {
    final response = await client.post(oscaUrl,
        body: createLoginPostContent(username, password));
    final result = LoginResult()
      ..cookie = getCookie(response.headers)
      ..sessionId = getSessionId(response.headers);
    return result;
  }

  static Map<String, String> createLoginPostContent(
    String username,
    String password,
  ) {
    return <String, String>{
      'usrname': username,
      'pass': password,
      'menuno': '002298',
      'APPNAME': 'CampusNet',
      'clino': '000000000000001',
      'persono': '00000000',
      'platform': '',
      'PRGNAME': 'LOGINCHECK',
      'ARGUMENTS': 'clino,usrname,pass,menuno,persno,browser,platform',
    };
  }

  static String getCookie(Map<String, String> headers) {
    final cookie = headers['set-cookie'];
    // Manchmal sendet der Server die Cookies mit Leerzeichen drin.
    // Aber der Server akzeptiert die Cookies nicht mit einem Leerzeichen darin.
    // => Also Leerzeichen entfernen
    return cookie.replaceAll(' ', '');
  }

  static String getSessionId(Map<String, String> headers) {
    final refreshUrl = headers['refresh'];
    final regex = RegExp('ARGUMENTS=-N(.*?),');
    final match = regex.firstMatch(refreshUrl);
    var result = refreshUrl.substring(match.start, match.end);
    result = result.replaceAll('ARGUMENTS=-N', '');
    result = result.substring(0, result.length - 1);
    return result;
  }
}

class LoginResult {
  String cookie;
  String sessionId;
}
