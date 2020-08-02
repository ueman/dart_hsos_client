import 'package:flutter_test/flutter_test.dart';
import 'package:osca_dart/web/announcements.dart';
import 'package:osca_dart/web/file_area.dart';
import 'package:osca_dart/web/osca_web_client.dart';

final String fedAuthCookieValue =
    '77u/PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48U1A+MMe1LnR8YWRmczIwfGp1ZWtvZXR0LDDHtS50fGFkZnMyMHxqdWVrb2V0dCwxMzIwNDgyMTk0NjgwMjc5NjUsVHJ1ZSxVR0dBanl2N1JGcHlpMGFINENQVEJqUnZXV0FTUFlCZXlvR1ZpQjNNVmhqMjFvTmowb1U2enRWcWtYMUVuUDZwTktESE1jakgxT29KeDB2VHlpNzY4dkI5ZUlSOWxnZ212ZDBPK044OVJqcDlSb2NFZVdNTUF3WjJWSDIvSTUzRVdGd2FjVEhhZ2Y5R2doVHlQZFJubUh0OElhcHJMVVlFcUFKck5lSDR3OVRYRmtkZTdJYllFeGtKOHhoSWNtMHhmNEFOU1ZVaEg5SkJrUWtWWElGM3ZBenZMajdxYXcvU09oVnRYbHRMYlZMeG41RVJRTmhiSEY4ZW1yY1NKcmI5eTUyNjloV2R2ellMNUdDTzB2MWJ4Rng3OHpqU1M2bEJVZU5sRmhFZEVwZDIxRTBzVU4zakRhQTNaYWlIcXNNZ3h6STdlVE5PNXRBaHhsSzNzemhyZXc9PSxodHRwczovL29zY2EuaHMtb3NuYWJydWVjay5kZS88L1NQPg==';

void main() {
  test('checks exceptions of OscaWebClient', () {
    expect(() => OscaWebClient("FedAuth"), throwsException);
  });

  test('test download of files', () async {
    var client = OscaWebClient(fedAuthCookieValue);
    try {
      var courseFiles =
          await FileArea.getListOfAllFilesForCourse(client, '370183926232552');
      print(courseFiles);
    } finally {
      client.close();
    }
  });

  test('test fetching of announcements', () async {
    var client = OscaWebClient(fedAuthCookieValue);
    try {
      var announcements = await Announcements.getAllAnnouncementsForCourse(
          client, '370184054259614');
    } finally {
      client.close();
    }
  });
}
