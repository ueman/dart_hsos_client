import 'dart:convert';

import 'package:http/http.dart';
import 'package:osca_dart/app/login.dart';
import 'package:osca_dart/app/models/appointment.dart';
import 'package:osca_dart/app/models/course.dart';
import 'package:osca_dart/app/models/exam.dart';
import 'package:osca_dart/app/osca_app_client.dart';
import 'package:osca_dart/app/osca_app_url_builder.dart';

class OscaAppApi {
  OscaAppClient _client;
  LoginResult _loginResult;

  /// Loggt den Nutzer ein.
  /// Muss aufgerufen werden, bevor irgendwas anderes
  /// in dieser Klasse genutzt werden kann.
  Future<bool> login(String username, String password) async {
    final client = Client();
    _loginResult = await Login.login(client, username, password);
    _client = OscaAppClient(_loginResult);
    client.close();
    return true;
  }

  /// Gibt eine Liste *aller* je belegten Module zurück
  Future<List<Course>> getCourses() async {
    _isClientInitialized();
    final eventUrl = OscaAppUrlBuilder.eventsUrl(_loginResult.sessionId, 'STD');
    final response = await _client.get(eventUrl);
    return Course.fromXml(utf8.decode(response.bodyBytes));
  }

  /// Gibt eine Liste *aller* je belegten Module zurück
  /// Die neusten Kurse sind die ersten in der Liste
  Future<List<Course>> getCoursesSortedByCourseDesc() async {
    final courses = await getCourses();
    // courseIDs sind aufsteigende Integer.
    // Je älter der Kurs, desto kleiner die courseId
    courses.sort((a, b) => b.courseID.compareTo(a.courseID));
    return courses;
  }

  /// Gibt eine Liste mit Noten zu belegten Prüfungen zurück
  Future<List<Exam>> getExams() async {
    _isClientInitialized();
    final examUrl = OscaAppUrlBuilder.examsUrl(_loginResult.sessionId, 'STD');
    final response = await _client.get(examUrl);
    return Exam.fromXml(utf8.decode(response.bodyBytes));
  }

  /// Gibt alle Termine zurück.
  /// Dies ist quasi der Stundenplan.
  Future<List<Appointment>> getAppointments() async {
    _isClientInitialized();
    final url = OscaAppUrlBuilder.appointmentsUrl(_loginResult.sessionId);
    final response = await _client.get(url);
    return Appointment.fromXml(utf8.decode(response.bodyBytes));
  }

  void _isClientInitialized() {
    if (_client == null) {
      throw Exception(
          'You must call login before using any other method of this class');
    }
  }
}
