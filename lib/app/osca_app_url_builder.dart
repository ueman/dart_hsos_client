import 'package:osca_dart/app/magic/encoder.dart';
import 'package:osca_dart/app/magic/string_utils.dart';

// ignore: avoid_classes_with_only_static_members
class OscaAppUrlBuilder {
  static const String baseUrl =
      'https://osca-bew.hs-osnabrueck.de/scripts/mgrqispi.dll?APPNAME=CampusNet&PRGNAME=ACTIONMOBILE&ARGUMENTS=';

  /// Baut eine URL zusammen, mit der der Status
  /// des aktuellen Nutzer abgefragt werden kann.
  /// Der Status ist entweder STD oder DOZ
  static String personTypeUrl(String sessionId) {
    final url = 'GETPERSONTYPE,$sessionId,000000,1';
    final urlWithMd5 = '${StringUtils.toMd5(url)},$url';
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  /// Baut die Stundenplan URL
  static String appointmentsUrl(String sessionId) {
    final String url = 'GETAPPOINTMENTS,$sessionId,000000,';
    final String urlWithMd5 = StringUtils.toMd5(url) + ',' + url;
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  /// Baut die URL zur Abfrage von Nachrichten (quasi Ankündigungen)
  /// zusammen.
  static String messagesUrl(String sessionId) {
    final url = 'GETMESSAGES,$sessionId,000000,';
    final urlWithMd5 = StringUtils.toMd5(url) + ',' + url;
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  /// Baut die URL zur Abfrage von weiteren Modul-Informationen
  static String eventInfoUrl(String sessionId, String eventId) {
    final String url = 'GETEVENTINFO,$sessionId,000000,$eventId';
    final String urlWithMd5 = StringUtils.toMd5(url) + ',' + url;
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  /// Baut die URL zur Abfrage von allen Modulen
  static String eventsUrl(String sessionId, String personType) {
    validPersonType(personType);
    final String url = 'GETEVENTS,$sessionId,000000,$personType';
    final String urlWithMd5 = StringUtils.toMd5(url) + ',' + url;
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  /// Baut die URL zur Abfrage von allen Noten
  static String examsUrl(String sessionId, String personType) {
    validPersonType(personType);
    final String url = 'GETEXAMS,$sessionId,000000,$personType';
    final String urlWithMd5 = StringUtils.toMd5(url) + ',' + url;
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  /// liefert bei Osca nix tolles
  static String getMaterialsUrl(
      String sessionId,
      String objectId /* StudentEvent.id oder Appointment.id */,
      String objectType) {
    if (objectType != 'EVENT' && objectType != 'TIMETABLE') {
      throw Exception(
          'objectType must be EVENT or TIMETABLE but was $objectType');
    }

    final String url = 'GETMATERIAL,$sessionId,000000,$objectId,$objectType';

    final String urlWithMd5 = StringUtils.toMd5(url) + ',' + url;
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  /// liefert bei Osca nix tolles
  static String getEventDownloadUrl(
      String sessionId, String irgendwasVomMaterial) {
    final String url =
        'GETEVENTDOWNLOAD,$sessionId,000000,$irgendwasVomMaterial';
    final String urlWithMd5 = StringUtils.toMd5(url) + ',' + url;
    return '$baseUrl-A${Encoder.doMagicWithString(urlWithMd5)}';
  }

  static void validPersonType(String personType) {
    if (personType != 'STD' && personType != 'DOZ') {
      throw Exception('Persontype must be STD or DOZ but was $personType');
    }
  }
}
