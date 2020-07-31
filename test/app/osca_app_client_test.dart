import 'package:http/http.dart';
import 'package:osca_dart/app/login.dart';
import 'package:osca_dart/app/osca_app_client.dart';
import 'package:osca_dart/app/osca_app_url_builder.dart';
import 'package:test/test.dart';

void main() {
  test('test login', () async {
    var client = Client();
    try {
      var loginresult = await Login.login(client, 'redacted', 'redacted');
      var appClient = OscaAppClient(loginresult);

      var appointments =
          OscaAppUrlBuilder.appointmentsUrl(loginresult.sessionId);

      var content = await appClient.get(appointments);
      var body = content.body;
      var messages = OscaAppUrlBuilder.messagesUrl(loginresult.sessionId);
      var i = 1;
    } finally {
      client.close();
    }
  });
}
