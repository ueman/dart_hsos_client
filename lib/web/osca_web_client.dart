import 'package:http/http.dart';

/// Stellt einen HttpClienten speziell für die
/// Webschnittstellen der Osca-Web bereit
class OscaWebClient extends BaseClient {
  OscaWebClient(this._fedAuthCookie);

  static const userAgent =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36';
  static const accept = 'application/json;odata=verbose';

  final String _fedAuthCookie;

  final Client _inner = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['User-Agent'] = userAgent;
    request.headers['Cookie'] = 'FedAuth=$_fedAuthCookie';
    request.headers['Accept'] = accept;
    return _inner.send(request);
  }
}
