import 'package:osca_dart/web/osca_web_client.dart';

class ConnectionTest {
  /// Easy check um zu schauen, ob der Cookie des [client] auch valide ist.
  Future<bool> testConnection(OscaWebClient client) async {
    final response = await client.get('https://osca.hs-osnabrueck.de');
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
