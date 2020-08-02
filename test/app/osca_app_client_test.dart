import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:osca_dart/app/login.dart';
import 'package:osca_dart/app/osca_app_client.dart';
import 'package:osca_dart/app/osca_app_url_builder.dart';

void main() {
  test('test login', () async {
    var client = Client();
    var loginresult = await Login.login(client, 'user', 'password');
    var appClient = OscaAppClient(loginresult);

    var appointments = OscaAppUrlBuilder.appointmentsUrl(loginresult.sessionId);

    var content = await appClient.get(appointments);
    print(content.body);
    var messages = OscaAppUrlBuilder.messagesUrl(loginresult.sessionId);
    var i = 1;
  });

  // Beispiel Session ID: 669215783154895
  // Mw2Rj~qRXmczejWZGMXxB1aOqpIOD5rmYmJ0jXZ2ZcleH9bgdbxaUxweKX1Xl09RbmZ3si9DMw48c-RGyOSi6B7F9wPwW~q6X3ViGXV6huS-7eIlxMqp6TklbJIjI~C78po9H7lItQZMAHpH7Vk55NjJY~0_

  test('test build of url', () async {

    // Beispiel Session ID: 498554885101158
    final url = OscaAppUrlBuilder.examsUrl('498554885101158', 'STD');
    expect(url, '${OscaAppUrlBuilder.baseUrl}-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB0KU2Fzv8xYFB4uwiWgJyo1J41doowzdKHJOaIFIfcV1DxdSC1XJUHIhHA5wf6ytu-TubSxQJsCw8OGKxnQ7bwI8U58pXqNHISmPoIXwljbVmcJXw_');
  });
}
