/// Bildet eine Datei in einem Dateibereich ab
class CourseFile {
  
  /// Id des Kurses
  String courseId;

  // Name der Datei
  String name;

  String serverRelativeUrl;

  /// Vollständige URL der Datei
  String downloadUrl() => "https://osca.hs-osnabrueck.de$serverRelativeUrl";

  String created;

  String lastModified;
}