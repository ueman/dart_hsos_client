import 'package:http/http.dart';
import 'package:osca_dart/app/login.dart';

/// Stellt einen HttpClienten speziell für die
/// Webschnittstellen der Osca-App bereit
class OscaAppClient extends BaseClient {
  OscaAppClient(this._loginResult);
  final LoginResult _loginResult;

  final Client _inner = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Cookie'] = _loginResult.cookie;
    return _inner.send(request);
  }
}
