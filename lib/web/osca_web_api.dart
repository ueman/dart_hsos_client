import 'dart:typed_data';

import 'package:osca_dart/app/models/course.dart';
import 'package:osca_dart/web/announcements.dart';
import 'package:osca_dart/web/connection_test.dart';
import 'package:osca_dart/web/file_area.dart';
import 'package:osca_dart/web/models/announcement.dart';
import 'package:osca_dart/web/models/course_file.dart';
import 'package:osca_dart/web/osca_web_client.dart';

/// Stellt einen HttpClienten speziell für die
/// Webschnittstellen des Osca-Portals bereit
class OscaWebApi {
  OscaWebApi(String fedAuthCookie) : assert(fedAuthCookie != null) {
    _client = OscaWebClient(fedAuthCookie);
  }

  OscaWebClient _client;

  Future<Uint8List> loadFile(CourseFile file) async {
    final response = await _client.get(file.downloadUrl());
    return response.bodyBytes;
  }

  /// Check um zu schauen, ob der Cookie funktioniert.
  Future<bool> canConnect() {
    return ConnectionTest().testConnection(_client);
  }

  Future<List<CourseFile>> getListOfAllFilesForCourse(String courseId) {
    return FileArea.getListOfAllFilesForCourse(_client, courseId);
  }

  Future<List<Announcement>> getAllAnnouncementsForCourse(String courseId) {
    return Announcements.getAllAnnouncementsForCourse(_client, courseId);
  }
}
