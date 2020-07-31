import 'package:http/http.dart';

/// Stellt einen HttpClienten speziell für die
/// Webschnittstellen des Osca-Portals bereit
class OscaWebClient extends BaseClient {

  String userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36';
  String accept = 'application/json;odata=verbose';
  final String fedAuthCookie;

  final Client _inner = Client();

  OscaWebClient(this.fedAuthCookie){
    if(fedAuthCookie.toLowerCase().contains('fedauth')){
      throw Exception('The FedAuth cookie should only contain the cookie value');
    }
  }

  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['User-Agent'] = userAgent;
    request.headers['Cookie'] = "FedAuth=${fedAuthCookie}";
    request.headers['Accept'] = accept;
    return _inner.send(request);
  }
}