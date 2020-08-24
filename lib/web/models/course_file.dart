/// Bildet eine Datei in einem Dateibereich ab
class CourseFile {
  /// Id des Kurses
  String courseId;

  /// Name der Datei
  String name;

  /// Relativer Pfad zur Datei
  String serverRelativeUrl;

  /// Vollständige URL der Datei
  String downloadUrl() => 'https://osca.hs-osnabrueck.de$serverRelativeUrl';

  String created;

  String lastModified;

  /// Gibt den relativen Pfad zur Datei an. Die einzelnen Teile des Pfads
  /// sind dabei in der Liste.
  List<String> pathSegments() {
    final pathSegments = serverRelativeUrl
        .split('/')
        // das erste Element der Liste ist ein leerer String
        .where((segment) => segment != null && segment.trim().isNotEmpty)
        // skip 3 weil der Path mit "/lms/{courseId}/dat/" anfängt
        .skip(3)
        .toList();
    return pathSegments;
  }
}
